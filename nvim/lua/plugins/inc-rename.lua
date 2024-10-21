return {
  "smjonas/inc-rename.nvim",
  config = function()
    require("inc_rename").setup()
  end,
  event = "LspAttach",
  keys = {
    { "<leader>rn", ":IncRename ", desc = "Rename under curosr" },
  },
}
