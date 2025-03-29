return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre", -- Lazy load on buffer read
  config = function()
    require "configs.lspconfig"
  end,
}
