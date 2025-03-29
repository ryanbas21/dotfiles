return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo +nightly build --release",
  version = "1.*",
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
    "onsails/lspkind.nvim",
    "zbirenbaum/copilot.lua",
    "olimorris/codecompanion.nvim",
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
      dependencies = {
        {
          "mrcjkb/haskell-snippets.nvim",
        },
        {
          "rafamadriz/friendly-snippets",
        },
      },
      keys = {
        {
          "<C-k>",
          function()
            require("luasnip").expand()
          end,
          mode = { "i" },
        },
        {
          "<C-j>",
          function()
            require("luasnip").jump(1)
          end,
          mode = { "i", "s" },
        },
        {
          "<C-l>",
          function()
            require("luasnip").jump(-1)
          end,
          mode = { "i", "s" },
        },
        {
          "<C-e>",
          function()
            local ls = require "luasnip"
            if ls.choice_active() then
              ls.change_choice(1)
            end
          end,
          mode = { "i", "s" },
        },
      },
    },
  },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      kind_icons = {
        Copilot = "",
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
    },
    signature = {

      enabled = true,
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
      ghost_text = {
        enabled = true,
      },
    },

    cmdline = {
      enabled = false,
    },
    sources = {
      default = { "lsp", "snippets", "path", "buffer", "codecompanion" },
      providers = {
        copilot = {
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
          module = "blink-cmp-copilot",
          score_offset = 100,
          -- async = true,
        },
      },
    },
    snippets = {
      preset = "luasnip",
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },

    keymap = {
      preset = "enter",
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    },
  },
}
