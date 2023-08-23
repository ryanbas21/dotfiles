local telescope_lsp = require "telescope_config.lsp"

-- Finds and runs the closest codelens (searches upwards only)
local function find_and_run_codelens()
    local bufnr = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local lenses = vim.lsp.codelens.get(bufnr)

    lenses = vim.tbl_filter(function(lense)
        return lense.range.start.line < row
    end, lenses)

    if #lenses == 0 then
        return vim.api.nvim_echo({ { "Could not find codelens to run.", "WarningMsg" } }, false, {})
    end

    table.sort(lenses, function(a, b)
        return a.range.start.line > b.range.start.line
    end)

    vim.api.nvim_win_set_cursor(0, { lenses[1].range.start.line + 1, lenses[1].range.start.character })
    vim.lsp.codelens.run()
    vim.api.nvim_win_set_cursor(0, { row, col }) -- restore cursor, TODO: also restore position
end

---@param bufnr integer
local function buf_set_keymaps(bufnr)
    local function buf_set_keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
    end

    local function format(client)
        vim.api.nvim_echo({ { ("Formatting with %s…"):format(client.name) } }, false, {})
        vim.lsp.buf.format { id = client.id }
    end

    buf_set_keymap("n", "<leader>p", function()
        local candidates = vim.tbl_filter(function(client)
            return client.name ~= "sumneko_lua" and client.supports_method "textDocument/formatting"
        end, vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() })
        if #candidates > 1 then
            vim.ui.select(candidates, {
                prompt = "Client",
                format_item = function(client)
                    return client.name
                end,
            }, function(client)
                if client then
                    format(client)
                end
            end)
        elseif #candidates == 1 then
            format(candidates[1])
        else
            vim.api.nvim_echo(
                { { "No clients that support textDocument/formatting are attached.", "WarningMsg" } },
                false,
                {}
            )
        end
    end)

    -- Code actions
    buf_set_keymap("n", "<leader>lrn", vim.lsp.buf.rename)
    buf_set_keymap("n", "<space>lqf", vim.lsp.buf.code_action)
    buf_set_keymap("n", "<space>ld", vim.lsp.diagnostic.get_line_diagnostics)
    buf_set_keymap("n", "<leader>lcl", find_and_run_codelens)

    -- Movement
    buf_set_keymap("n", "gD", "<cmd>Trouble lsp_type_definitions<CR>")
    buf_set_keymap("n", "gd", "<cmd>Trouble lsp_definitions<CR>")
    buf_set_keymap("n", "gr", "<cmd>Trouble lsp_references<CR>")
    buf_set_keymap("n", "gI", "<cmd>Trouble lsp_implementations<CR>")

    -- Docs
    buf_set_keymap("n", "<M-p>", vim.lsp.buf.signature_help)
    buf_set_keymap("i", "<M-p>", vim.lsp.buf.signature_help)

    buf_set_keymap("n", "<C-p>ws", telescope_lsp.workspace_symbols)
    buf_set_keymap("n", "<C-p>wd", "<cmd>Trouble workspace_diagnostics")
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        buf_set_keymaps(bufnr)
    end,
})
