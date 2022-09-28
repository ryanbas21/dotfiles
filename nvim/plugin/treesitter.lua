require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        ignore_install = { "phpdoc" },
        highlight = { enable = true },
        indent = { enable = true, disable = { "python", "yaml", "tsx" } },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
        },
        matchup = {
            enable = true,
        },
    }
