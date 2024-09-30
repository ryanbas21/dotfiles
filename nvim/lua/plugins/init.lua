return {
  { "dmmulroy/ts-error-translator.nvim" },
  { "folke/neodev.nvim" },
  "marilari88/twoslash-queries.nvim",
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "cssls",
        "prettier",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  "lewis6991/hover.nvim",
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/nvim-nio",
      "thenbe/neotest-playwright",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  -- tpope
  { "tpope/vim-repeat", lazy = true, event = "BufEnter" },
  { "tpope/vim-surround", lazy = true, event = "BufEnter" },
  { "tpope/vim-dispatch", lazy = true, event = "BufEnter" },
  "radenling/vim-dispatch-neovim",
  { "rhysd/git-messenger.vim", cmd = "GitMessenger", lazy = true },
  { "lewis6991/gitsigns.nvim", event = "BufEnter", lazy = true },
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = { "<leader>go" },
    lazy = true,
  },
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "VidocqH/lsp-lens.nvim", event = "LspAttach", lazy = true },
  "b0o/schemastore.nvim",
  {
    "LukasPietzschmann/boo.nvim",
    keys = {
      {
        "<C-a>",
        function()
          require("boo").boo()
        end,
      },
    },
    opts = {
      focus_on_open = false,
      close_on_mouse_move = true,
      win_opts = {
        title = "",
      },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/nvim-dap-vscode-js",
    },
  },
  "lewis6991/gitsigns.nvim",
  {
    "luckasRanarison/clear-action.nvim",
    opts = {},
  },
}
