local plugins = {
        {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', event = "BufEnter", lazy = true },
        'zaldih/themery.nvim',
        -- tpope
        { "tpope/vim-repeat", lazy = true, event = "BufEnter" },
        { "tpope/vim-surround", lazy = true, event = "BufEnter" },
        { "tpope/vim-dispatch", lazy = true, event = "BufEnter" },
        "radenling/vim-dispatch-neovim",
       {
        "Dhanus3133/LeetBuddy.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim",
        },
        cmd = "LBQuestions",
        lazy = true
      },

      "nyoom-engineering/oxocarbon.nvim",
      { "AlexvZyl/nordic.nvim", config = function()
          require 'nordic' .load()
        end
      },
      "EdenEast/nightfox.nvim",
      "olimorris/onedarkpro.nvim",
      { "cryptomilk/nightcity.nvim", version = '*' },
    -- test & debugging
        {
          "nvim-neotest/neotest",
          dependencies = {
            "haydenmeade/neotest-jest",
            'marilari88/neotest-vitest',
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-plenary",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/nvim-dap-vscode-js",
            "thenbe/neotest-playwright",
        },
        lazy = true,
        cmd = { "Neotest" }
      },

        -- things that either enhance builtin behaviours or could easily be candidates for default behaviour
        { "akinsho/toggleterm.nvim", lazy = true },
        { "antoinemadec/FixCursorHold.nvim", lazy = true, event = "BufEnter" },
        { "lewis6991/hover.nvim", lazy = true, keys = { "K", "gK" } },
        { "numToStr/Comment.nvim", lazy = true, event = "BufEnter" },
        "nvim-lualine/lualine.nvim",
        {
          "stevearc/aerial.nvim",
           event = "LspAttach",
           lazy = true,
           dependencies = {
           "nvim-treesitter/nvim-treesitter",
           "nvim-tree/nvim-web-devicons"
          }
        },
        { "windwp/nvim-autopairs", event = "BufEnter", lazy = true },
        { 'j-hui/fidget.nvim', tag = 'legacy' },
        { "williamboman/notifier.nvim", branch = "feat/left-aligned-content" },
        { "zbirenbaum/copilot.lua", event = "InsertEnter", lazy = true },
        { "hrsh7th/nvim-cmp",
          lazy = true,
          event = "InsertEnter",
          dependencies = {
           "zbirenbaum/copilot-cmp",
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-nvim-lsp",
           "hrsh7th/cmp-path",
           "lukas-reineke/cmp-rg",
           "rcarriga/cmp-dap",
           "petertriho/cmp-git",
            "saadparwaiz1/cmp_luasnip",
          }
        },
        {
            "L3MON4D3/LuaSnip",
            lazy = true,
            event = "InsertEnter",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
             "rafamadriz/friendly-snippets"
          },
        { "nvim-neo-tree/neo-tree.nvim", cmd = "Neotree", lazy = true},
        "s1n7ax/nvim-window-picker",
        "nvim-lua/plenary.nvim",
        { "kyazdani42/nvim-web-devicons", lazy = true},
        "MunifTanjim/nui.nvim",
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

        -- UI
        "kyazdani42/nvim-web-devicons",
        { "lukas-reineke/indent-blankline.nvim", event = "BufEnter", lazy = true },
        "NvChad/nvim-colorizer.lua",

    -- Treesitter
    "nvim-treesitter/playground",
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    },

    -- Mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "lukas-reineke/lsp-format.nvim",
        { "b0o/SchemaStore.nvim", event = "LspAttach", ft = { "json", "yaml", "yml", "json5", ".eslintrc", ".eslint", ".env"  }, lazy = true },
        { "ray-x/lsp_signature.nvim", event = "LspAttach" },
        { "folke/trouble.nvim",
          event = "LspAttach",
          dependencies = { "nvim-tree/nvim-web-devicons" },
          lazy = true
        },
        { "simrat39/rust-tools.nvim", ft = "rs", lazy = true },
        "jose-elias-alvarez/null-ls.nvim",
        {
          "pmizio/typescript-tools.nvim",
          dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
          opts = {},
        },
        { "jmbuhr/otter.nvim",
           ft = { "md", "txt" },
           lazy = true,
           dependencies = {
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter'
          },
        },
        { "onsails/lspkind-nvim", event = "LspAttach", lazy = true },
        { "kosayoda/nvim-lightbulb", event = "LspAttach", lazy = true },
        { 'VidocqH/lsp-lens.nvim', event = "LspAttach", lazy = true },

    -- Telescope
      { "nvim-telescope/telescope.nvim",
         dependencies = {
          "nvim-telescope/telescope-project.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope-ui-select.nvim",
          { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
         }
      },
      { "ThePrimeagen/refactoring.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-treesitter/nvim-treesitter",
        }
      },
    -- git
        { "rhysd/git-messenger.vim", cmd = "GitMessenger", lazy = true },
        { "TimUntersberger/neogit", cmd = "Neogit", dependencies = { "sindrets/diffview.nvim" }, lazy = true },
        { "lewis6991/gitsigns.nvim", event = "BufEnter", lazy = true },
        { "ruifm/gitlinker.nvim",
          dependencies = {
            "nvim-lua/plenary.nvim",
          },
          keys = { "<leader>go" },
          lazy = true
        },
    -- Misc
    { "tweekmonster/startuptime.vim", cmd = "StartupTime", lazy = true },
}

require("lazy").setup(plugins)
