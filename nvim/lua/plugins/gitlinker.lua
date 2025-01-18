return {
  "linrongbin16/gitlinker.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>gb",
      '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      { desc = "create-link-to-code-on-github", silent = true },
    },
  },
}
