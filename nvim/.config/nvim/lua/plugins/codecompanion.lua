return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    -- "ravitemer/codecompanion-history.nvim",
    "ravitemer/mcphub.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  opts = {
    extensions = {
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
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = "cmd: pass show anthropic/oauth_token",
            },
          })
        end,
      },
      http = {},
    },
    strategies = {
      chat = {
        adapter = "claude_code",
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
        adapter = "claude_code",
      },
      agent = {
        adapter = "claude_code",
      },
    },
  },
  keys = {
    {
      "<leader>cc;",
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
