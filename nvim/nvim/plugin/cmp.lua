local deps_ok, cmp, types, luasnip, cmp_dap, lspkind, cmp_git = pcall(function()
    return require "cmp",
        require "cmp.types",
        require "luasnip",
        require "cmp_dap",
        require "lspkind",
        require "cmp_git"
end)

if not deps_ok then
    return
end
local mapping = cmp.mapping

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or cmp_dap.is_dap_buffer()
    end,
    formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text"
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
        ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
        ["<C-k>"] = mapping(function(fallback)
            if cmp.open_docs_preview() then
                cmp.close()
            else
                fallback()
            end
        end),
        ["<C-Space>"] = mapping.complete(),
        ["<C-e>"] = mapping.abort(),
        ["<CR>"] = mapping.confirm { select = false },
        ["<C-n>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-p>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        ["<Tab>"] = mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item { behavior = types.cmp.SelectBehavior.Select }
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Select }
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp"},
        -- { name = "copilot"},
        { name = "buffer",
          entry_filter = function()
              local context = require("cmp.config.context")
              return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
            end,
        },
        { name = "path", group_index = 3 },
        { name = "luasnip", group_index = 3,
           entry_filter = function()
              local context = require("cmp.config.context")
              return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
            end,
        },
        { name = "rg", group_index = 3 },
        { name = "git", group_index = 3 },
    },
}

cmp_git.setup {
    enableRemoteUrlRewrites = true,
}
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})
