return {
  "jinzhongjia/LspUI.nvim",
  enabled = false,
  branch = "main",
  event = "LspAttach",
  config = function()
    require("LspUI").setup {
      -- config options go here
    }
  end,
}
