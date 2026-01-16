return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  keys = {
    {
      "<leader>mp",
      ":Markview toggle<CR>",
      desc = "Toggle Markdown Preview",
    },
  },
  -- Completion for `blink.cmp`
  dependencies = { "saghen/blink.cmp" },
}
