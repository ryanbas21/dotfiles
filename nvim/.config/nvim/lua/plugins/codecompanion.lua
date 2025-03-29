return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp",
    "j-hui/fidget.nvim",
  },
  opts = {
    adapters = {
      chat = {
        adapter = "copilot",
        keymaps = {
          hide = {
            modes = {
              n = "q",
            },
            callback = function(chat)
              chat.ui:hide()
            end,
            description = "AI: Hide the chat buffer",
          },
        },
      },
      inline = {
        adapter = "copilot",
      },
      agent = {
        adapter = "copilot",
      },
    },
    prompt_library = {
      ["Code Expert"] = {
        strategy = "chat",
        description = "Get some special advice from an LLM",
        opts = {
          mapping = "<LocalLeader>ce",
          modes = { "v" },
          short_name = "expert",
          auto_submit = true,
          stop_context_insertion = true,
          user_prompt = true,
        },
      },
      ["Test workflow"] = require("configs.codecompanion.workflows.test_workflow").test_workflow,
      ["JS Docs"] = require("configs.codecompanion.workflows.js_docs").js_docs,
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("codecompanion").toggle()
      end,
      { "n", "v" },
      "AI: Toggle chat buffer",
    },
    {
      "<leader>al",
      function()
        require("codecompanion").prompt "lsp"
      end,
      { "n", "v" },
      "AI: Explain LSP diagnostics",
    },
    {
      "<leader>ai",
      function()
        require("codecompanion").prompt "inline"
      end,
      { "n", "v" },
      "AI: Inline",
    },
    {
      "<leader>ae",
      function()
        require("codecompanion").prompt "expert"
      end,
      { "v" },
      "AI: Explain snippet",
    },
    {
      "<leader>af",
      function()
        require("codecompanion").prompt "fix"
      end,
      { "v" },
      "AI: Fix snippet",
    },
    {
      "<leader>cc",
      ":CodeCompanion<CR>",
      "Code Companion",
    },
    {
      "<leader>cc;",
      ":CodeCompanionActions<CR>",
      "Code Companion Actions",
    },
    {
      "<leader>ccjs",
      function()
        require("codecompanion").prompt "js_docs"
      end,
      mode = { "v", "n" },
      desc = "Run test AI workflow",
    },
    {
      "<leader>cct",
      function()
        require("codecompanion").prompt "test"
      end,
      mode = { "v", "n" },
      desc = "Run test AI workflow",
    },
  },
  init = function()
    require("configs.codecompanion.spinner"):init()
  end,
}
