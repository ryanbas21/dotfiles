-- Enable nvim-treesitter highlighting explicitly; Neovim's defaults alone
-- don't start tree-sitter highlighting for every supported filetype.
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
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
    highlight = {
      enable = true,
    },
  },
}
