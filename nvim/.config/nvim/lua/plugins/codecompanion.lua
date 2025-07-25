return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "ravitemer/codecompanion-history.nvim",
    "ravitemer/mcphub.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  opts = {
    extensions = {
      history = {
        enabled = true,
        keymap = "gh",
        expiration_days = 7,
        -- Picker interface (auto resolved to a valid picker)
        picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
        -- Customize picker keymaps (optional)
        picker_keymaps = {
          rename = { n = "r", i = "<M-r>" },
          delete = { n = "d", i = "<M-d>" },
          duplicate = { n = "<C-y>", i = "<C-y>" },
        },
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show mcp tool results in chat
          make_vars = true, -- Convert resources to #variables
          make_slash_commands = true, -- Add prompts as /slash commands
        },
      },
    },
    adapters = {
      http = {
        chat = {
          adapter = "copilot",
          model = "claude-sonnet-4",
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
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("codecompanion").toggle()
      end,
      mode = { "n", "v" },
      desc = "AI: Toggle chat buffer",
    },
    {
      "<leader>al",
      function()
        require("codecompanion").prompt "lsp"
      end,
      mode = { "n", "v" },
      desc = "AI: Explain LSP diagnostics",
    },
    {
      "<leader>ai",
      function()
        require("codecompanion").prompt "inline"
      end,
      mode = { "n", "v" },
      desc = "AI: Inline",
    },
    {
      "<leader>ae",
      function()
        require("codecompanion").prompt "expert"
      end,
      mode = { "v" },
      desc = "AI: Explain snippet",
    },
    {
      "<leader>af",
      function()
        require("codecompanion").prompt "fix"
      end,
      mode = { "v" },
      desc = "AI: Fix snippet",
    },
    {
      "<leader>cc",
      ":CodeCompanion<CR>",
      desc = "Code Companion",
    },
    {
      "<leader>cc;",
      ":CodeCompanionActions<CR>",
      desc = "Code Companion Actions",
    },
    {
      "<leader>ccjs",
      function()
        require("codecompanion").prompt "js_docs"
      end,
      mode = { "v", "n" },
      desc = "Run JS Docs AI workflow",
    },
    {
      "<leader>cct",
      function()
        require("codecompanion").prompt "test"
      end,
      desc = "Run test AI workflow",
    },
  },
  init = function()
    require("configs.codecompanion.spinner"):init()
  end,
}
