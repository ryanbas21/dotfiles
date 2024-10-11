return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = true,
    lazy = true,
    event = "BufEnter package.json",
  },
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  { "dmmulroy/ts-error-translator.nvim", lazy = true, ft = { "typescript", "typescriptreact" } },
  { "folke/neodev.nvim" },
  { "marilari88/twoslash-queries.nvim", lazy = true, event = "LSPAttach" },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- this makes format on save
    config = function()
      require "configs.conform"
    end,
    lazy = true,
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
      automatic_installation = true,
    },
  },
  "mfussenegger/nvim-lint",
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
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-jest", lazy = true, cmd = "Neotest" },
      { "marilari88/neotest-vitest", lazy = true, cmd = "Neotest" },
      { "nvim-neotest/nvim-nio", lazy = true, cmd = "Neotest" },
      { "thenbe/neotest-playwright", lazy = true, cmd = "Neotest" },
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    lazy = true,
    cmd = "Neotest",
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
    lazy = true,
    cmd = "Neogit",
    config = true,
  },
  -- tpope
  { "tpope/vim-repeat", lazy = true, event = "BufEnter" },
  { "tpope/vim-surround", lazy = true, event = "BufEnter" },
  { "lewis6991/gitsigns.nvim", event = "BufEnter", lazy = true },
  { "VidocqH/lsp-lens.nvim", event = "LspAttach", lazy = true },
  "b0o/schemastore.nvim",
  "lewis6991/gitsigns.nvim",
}
