return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup()
  end,
  keys = {
    {
      "<leader>ac",
      "<cmd>ClaudeCode<CR>",
      "Toggle Claude Code",
    },
  },
}
