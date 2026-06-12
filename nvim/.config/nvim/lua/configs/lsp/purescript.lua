local M = {}

local function notify(message, level)
  vim.schedule(function()
    vim.notify(message, level or vim.log.levels.INFO, { title = "purescriptls" })
  end)
end

local function get_client(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients { bufnr = bufnr, name = "purescriptls" }
  if #clients == 0 then
    clients = vim
      .iter(vim.lsp.get_clients { bufnr = bufnr })
      :filter(function(client)
        return client.name:find("purescript") ~= nil
      end)
      :totable()
  end

  return clients[1]
end

local function request_execute_command(client, bufnr, command, arguments, callback)
  client:request("workspace/executeCommand", {
    command = command,
    arguments = arguments or {},
  }, function(err, result)
    if err then
      notify(vim.inspect(err), vim.log.levels.ERROR)
      return
    end

    if callback then
      callback(result)
    end
  end, bufnr)
end

local function execute_command(bufnr, command, arguments, callback)
  local client = get_client(bufnr)
  if not client then
    notify("purescriptls is not attached", vim.log.levels.ERROR)
    return
  end

  request_execute_command(client, bufnr, command, arguments, callback)
end

local function remove_json_nulls(value, seen)
  if type(value) ~= "table" then
    return
  end

  seen = seen or {}
  if seen[value] then
    return
  end
  seen[value] = true

  for key, item in pairs(value) do
    if item == vim.NIL then
      value[key] = nil
    else
      remove_json_nulls(item, seen)
    end
  end
end

local function sanitize_code_action(action)
  -- Only sanitize the top-level optional CodeAction fields. Do not recurse into
  -- command.arguments: PureScript LS legitimately uses JSON null inside those
  -- argument arrays/objects, and Neovim can send vim.NIL back as JSON null.
  if action.edit == vim.NIL then
    action.edit = nil
  end
  if action.command == vim.NIL then
    action.command = nil
  end
  if type(action.command) == "table" and action.command.arguments == vim.NIL then
    action.command.arguments = nil
  end
end

function M.code_action()
  vim.lsp.buf.code_action {
    filter = function(action)
      -- purescript-language-server encodes absent CodeAction fields as JSON
      -- null. Neovim decodes those as vim.NIL (a userdata), which is truthy;
      -- the built-in code-action runner then tries to apply `edit = vim.NIL`
      -- as a WorkspaceEdit and crashes in vim.lsp.util.apply_workspace_edit().
      sanitize_code_action(action)

      -- This PureScript-specific interactive action is implemented by some
      -- clients/extensions, but Neovim's built-in code action runner cannot
      -- complete the extra module-selection flow. Use <leader>pi/<leader>pI.
      return not (action.title or ""):lower():find("select module", 1, true)
    end,
  }
end

---@param opts? { bufnr?: integer, prompt_qualifier?: boolean, qualifier?: string }
function M.import_module(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local uri = vim.uri_from_bufnr(bufnr)

  execute_command(bufnr, "purescript.getAvailableModules", {}, function(modules)
    modules = modules or {}
    table.sort(modules)

    vim.schedule(function()
      if vim.tbl_isempty(modules) then
        notify("No PureScript modules available to import", vim.log.levels.WARN)
        return
      end

      vim.ui.select(modules, { prompt = "PureScript import module:" }, function(module)
        if not module then
          return
        end

        local function add_import(qualifier)
          -- The PureScript LS expects a JSON null (not a missing argument) for an
          -- unqualified import: { module, null, uri }.
          execute_command(bufnr, "purescript.addModuleImport", {
            module,
            qualifier and qualifier ~= "" and qualifier or vim.NIL,
            uri,
          })
        end

        if opts.prompt_qualifier then
          vim.ui.input({ prompt = "Qualifier (empty for unqualified): " }, function(qualifier)
            if qualifier == nil then
              return
            end

            add_import(qualifier)
          end)
        else
          add_import(opts.qualifier)
        end
      end)
    end)
  end)
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param keymap fun(lhs: string, rhs: string|function, opts: string|vim.keymap.set.Opts, mode?: string|string[])
function M.on_attach(client, bufnr, keymap)
  if client.name ~= "purescriptls" then
    return
  end

  -- PureScript LS returns complete command actions already. Avoid a resolve pass
  -- returning fresh JSON null fields that bypass our code-action filter cleanup.
  if type(client.server_capabilities.codeActionProvider) == "table" then
    client.server_capabilities.codeActionProvider.resolveProvider = false
  end

  client.handlers["workspace/applyEdit"] = function(_, params)
    if not params or type(params.edit) ~= "table" then
      return { applied = false, failureReason = "Invalid workspace/applyEdit params" }
    end

    -- PureScript LS may also include JSON nulls inside WorkspaceEdit objects.
    -- The default handler quietly returns applied=false when those make
    -- apply_workspace_edit throw, so clean the edit before applying it.
    remove_json_nulls(params.edit)

    local ok, err = pcall(vim.lsp.util.apply_workspace_edit, params.edit, client.offset_encoding)
    if not ok then
      notify("Failed to apply workspace edit: " .. tostring(err), vim.log.levels.ERROR)
      return { applied = false, failureReason = tostring(err) }
    end

    return { applied = true }
  end

  -- Neovim's default exec_cmd refuses commands missing from the advertised
  -- executeCommandProvider list. PureScript LS has a few useful commands that
  -- are handled server-side but not always advertised, so execute them directly.
  local function run_command(cmd, ctx)
    request_execute_command(client, ctx.bufnr or bufnr, cmd.command, cmd.arguments)
  end
  for _, command in ipairs {
    "purescript.addClause-explicit",
    "purescript.addCompletionImport",
    "purescript.addModuleImport",
    "purescript.build",
    "purescript.caseSplit-explicit",
    "purescript.clean",
    "purescript.fixTypo",
    "purescript.getAvailableModules",
    "purescript.replaceAllSuggestions",
    "purescript.replaceSuggestion",
    "purescript.restartPscIde",
    "purescript.search",
    "purescript.sortImports",
    "purescript.startPscIde",
    "purescript.stopPscIde",
    "purescript.typedHole-explicit",
  } do
    client.commands[command] = run_command
  end

  keymap("<leader>ca", M.code_action, "LSP code action")

  keymap("<leader>pi", function()
    M.import_module { bufnr = bufnr }
  end, "PureScript import module")

  keymap("<leader>pI", function()
    M.import_module { bufnr = bufnr, prompt_qualifier = true }
  end, "PureScript import module with qualifier")
end

return M
