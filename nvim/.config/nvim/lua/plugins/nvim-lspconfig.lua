return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    require "configs.lsp.handlers"
  end,
}
