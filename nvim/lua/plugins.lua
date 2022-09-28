
local install_path = ("%s/site/pack/packer-lib/opt/packer.nvim"):format(vim.fn.stdpath "data")

local function install_packer()
    vim.fn.termopen(("git clone https://github.com/wbthomason/packer.nvim %q"):format(install_path))
end

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    install_packer()
end

vim.cmd.packadd { "packer.nvim" }

function _G.packer_upgrade()
    vim.fn.delete(install_path, "rf")
    install_packer()
end

vim.cmd.command { "PackerUpgrade", ":call v:lua.packer_upgrade()", bang = true }

local function spec(use)
    -- tpope
    use {
        "tpope/vim-repeat",
        "tpope/vim-surround",
        {
            "tpope/vim-dispatch",
            requires = { "radenling/vim-dispatch-neovim" },
        },
    }

    -- test & debugging
    use {
        {
            "nvim-neotest/neotest",
            requires = {
                "haydenmeade/neotest-jest",
                'marilari88/neotest-vitest',
                "rouge8/neotest-rust",
                "nvim-neotest/neotest-plenary",
            },
        },
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        { "williamboman/nvim-dap-vscode-js", branch = "feat/debug-cmd" },
    }

    -- things that either enhance builtin behaviours or could easily be candidates for default behaviour
    use {
        "akinsho/toggleterm.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "lewis6991/hover.nvim",
        "numToStr/Comment.nvim",
        "nvim-lualine/lualine.nvim",
        "stevearc/aerial.nvim",
        "windwp/nvim-autopairs",
        { "williamboman/notifier.nvim", branch = "feat/left-aligned-content" },
        {
          "zbirenbaum/copilot.lua",
        },
        {
            "hrsh7th/nvim-cmp",
            requires = {
             {
              "zbirenbaum/copilot-cmp",
              after = { "copilot.lua" },
            },
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "lukas-reineke/cmp-rg",
                "onsails/lspkind-nvim",
                "petertriho/cmp-git",
                "rcarriga/cmp-dap",
                "saadparwaiz1/cmp_luasnip",
                {
                    "L3MON4D3/LuaSnip",
                    requires = { "rafamadriz/friendly-snippets" },
                },
            },
        },
        {
            'Equilibris/nx.nvim',
            requires = {
                'nvim-telescope/telescope.nvim',
            }
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
        "s1n7ax/nvim-window-picker",
        "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
        },
    }

    -- UI
    use {
        "projekt0n/github-nvim-theme",
        "olimorris/onedarkpro.nvim",
        "kyazdani42/nvim-web-devicons",
        "lukas-reineke/indent-blankline.nvim",
        "NvChad/nvim-colorizer.lua",
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/playground",
        }
    }

    -- Mason
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    }

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        "b0o/SchemaStore.nvim",
        "ray-x/lsp_signature.nvim",
        "folke/trouble.nvim",
        "simrat39/rust-tools.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jose-elias-alvarez/typescript.nvim",
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    }

    -- git
    use {
        "rhysd/git-messenger.vim",
        "TimUntersberger/neogit",
        "lewis6991/gitsigns.nvim",
    }

    -- Misc
    use { "tweekmonster/startuptime.vim", cmd = { "StartupTime" } }
    use "wakatime/vim-wakatime"
end

require("packer").startup {
    spec,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
        max_jobs = vim.fn.has "win32" == 1 and 5 or nil,
    },
}
