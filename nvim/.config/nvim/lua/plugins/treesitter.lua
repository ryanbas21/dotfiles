-- Neovim 0.12 enables treesitter highlighting by default.
-- nvim-treesitter now only manages parser installation/updates.
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  opts = {
    ensure_installed = {
      "typescript",
      "javascript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "lua",
      "bash",
      "markdown",
      "markdown_inline",
      "regex",
      "haskell",
      "rust",
      "go",
      "purescript",
    },
    auto_install = true,
  },
}
