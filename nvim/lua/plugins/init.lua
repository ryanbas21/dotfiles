return {
  { "folke/neodev.nvim" },
  "marilari88/twoslash-queries.nvim",
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
        "ts_ls",
        "html-lsp",
        "cssls",
        "prettierd",
      },
    }
  },
  { "tpope/vim-repeat", lazy = true, event = "BufEnter" },
  { "tpope/vim-surround", lazy = true, event = "BufEnter" },
  "b0o/schemastore.nvim"
}
