return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ignore_install = { "org" },
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "typescript",
      "javascript",
    },
  },
}
