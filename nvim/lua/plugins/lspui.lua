return {
  "jinzhongjia/LspUI.nvim",
  branch = "main",
  event = "LspAttach",
  config = function()
    require("LspUI").setup {
      -- config options go here
    }
  end,
}
