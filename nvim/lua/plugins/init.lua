return {
  "marilari88/twoslash-queries.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  { "tpope/vim-repeat", lazy = true, event = "BufEnter" },
  { "tpope/vim-surround", lazy = true, event = "BufEnter" },
  "b0o/schemastore.nvim",
}
