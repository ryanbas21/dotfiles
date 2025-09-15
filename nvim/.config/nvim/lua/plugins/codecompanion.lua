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
    adapter = "gemini_cli",
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
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
            },
            env = {
              GOOGLE_CLOUD_PROJECT = os.getenv "GOOGLE_CLOUD_PROJECT" or "ryan-bas-sdk",
            },
          })
        end,
      },
      http = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
            },
            env = {
              GOOGLE_CLOUD_PROJECT = os.getenv "GOOGLE_CLOUD_PROJECT" or "ryan-bas-sdk",
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = "gemini",
        model = "gemini-live-2.5-flash",
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
        adapter = "gemini",
        model = "gemini-live-2.5-flash",
      },
      agent = {
        adapter = "gemini",
        model = "gemini-live-2.5-flash",
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
