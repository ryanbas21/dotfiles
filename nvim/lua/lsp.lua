local coq = require 'coq' -- add this
local saga = require 'lspsaga'


local lsp_installer_servers = require "nvim-lsp-installer.servers"
require("nvim-lsp-installer").setup {
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
      ui = {
          icons = {
              server_installed = "✓",
              server_pending = "➜",
              server_uninstalled = "✗"
          }
      }
  }

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  require "lsp_signature".on_attach(client, bufnr)
  -- Mappings.
  local opts = { noremap=true, silent=false }
  if client.resolved_capabilities.code_lens then
    buf_set_keymap('n', '<leader>lcld', '<cmd>lua vim.lsp.codelens.refresh()<CR>', { noremap=true, silent = true })
    buf_set_keymap('n', '<leader>lclr', '<cmd>lua vim.lsp.codelens.run()<CR>', { noremap=true, silent = true  })
  end
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gp', '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', opts)
  buf_set_keymap('n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-b>', '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
  buf_set_keymap('n', '<C-f>', '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<Cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts) buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end


-- Configure lua language server for neovim development
require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }

vim.api.nvim_set_keymap("n", "<space>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("n", "<space>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)

saga.init_lsp_saga()

local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    init_options = {documentFormatting = true},
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
    settings = {
      rootMarkers = {"./git/"}
    }
  }
end

-- lsp-install
local function setup_servers()
  local servers = lsp_installer_servers
  local lspconfig = require'lspconfig'

  vim.g.coq_settings = {
    ['auto_start'] = 'shut-up',
  }

  -- ... and add manually installed servers
  -- table.insert(servers, "sourcekit")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == 'purescript' then
      config.filetypes = {"purs", "purescript" }
      config.settings = {
        purescript = {
          addSpagoSources = true -- e.g. any purescript language-server config here
        }
      }
      config.flags = {
        debounce_text_changes = 150,
      }
    end
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "sourcekit" then
      config.filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
    end
    if server == "clangd" then
      config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
    end
    lspconfig[server].setup(coq.lsp_ensure_capabilities(config))
    end
end

setup_servers()
-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefaul" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      prefix = "",
      spacing = 0,
   },
   signs = true,
   underline = true,
   update_in_insert = false, -- update diagnostics insert mode
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

require('lspkind').init({
    with_text = true,
    preset = 'codicons',
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    },
})
