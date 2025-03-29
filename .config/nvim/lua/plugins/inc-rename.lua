return {
  "smjonas/inc-rename.nvim",
  event = "LspAttach",
  keys = {
    { "<leader>rn", ":IncRename ", desc = "Rename under curosr" },
  },
  config = function()
    require("inc_rename").setup {}
  end,
}
