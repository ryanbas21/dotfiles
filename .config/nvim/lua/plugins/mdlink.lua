return {
  "Nedra1998/nvim-mdlink",
  ft = { "md", "markdown" },
  opts = {
    keymap = true,
    cmp = true,
  },
  keys = {
    {
      "<leader>mcl",
      '<cmd>lua require("nvim-mdlink").follow_or_create()<CR>',
      { noremap = true, silent = true, expr = false, desc = "Create link" },
    },
  },
}
