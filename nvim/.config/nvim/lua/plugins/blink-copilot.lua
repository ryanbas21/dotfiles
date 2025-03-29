return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        trigger_on_accept = true,
        keymap = {
          accept = "<TAB>",
          auto_trigger = "<C-a>",
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = true, auto_refresh = true },
    }
  end,
  keys = {
    {
      "<leader>cp",
      function()
        require("copilot.panel").toggle()
      end,
      { desc = "Toggle Copilot Panel" },
    },
    {
      "<leader>cs",
      function()
        require("copilot.suggestion").toggle()
      end,
      { desc = "Toggle Copilot Suggestion" },
    },
    {
      "<leader>c<CR>",
      function()
        require("copilot.suggestion").accept()
      end,
      { desc = "Accept Copilot Suggestion" },
    },
    {
      "<C-d>",
      mode = { "i" },
      function()
        require("copilot.suggestion").dismiss()
      end,
      { desc = "Dismiss Copilot Suggestion" },
    },
    {
      "<C-s>",
      mode = { "i" },
      function()
        require("copilot.suggestion").next()
      end,
      { desc = "Next Copilot Suggestion" },
    },
    {
      "<C-b>",
      mode = { "i" },
      function()
        require("copilot.suggestion").prev()
      end,
      { desc = "Previous Copilot Suggestion" },
    },
  },
}
