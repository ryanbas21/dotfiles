  return {
    "nvim-treesitter/nvim-treesitter",
    pin = true,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript"
      },
    }
  }