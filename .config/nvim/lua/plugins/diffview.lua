return {
  "sindrets/diffview.nvim", -- optional - Diff integration
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  opts = {
    default_args = {
      DiffviewOpen = {},
    },
  },
  keys = {
    {
      "<leader>pr",
      ":DiffviewOpen origin/main...HEAD --imply-local<CR>",
      desc = "Review PR / branch",
    },
    {
      "dv",
      ":DiffviewOpen<CR>",
      desc = "Open Diffview",
    },
    {
      "dc",
      ":DiffviewClose<CR>",
    },
  },
}
