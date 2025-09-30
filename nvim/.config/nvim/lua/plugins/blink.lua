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
      ghost_text = {
        enabled = true,
        priority = 10,
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind", "source_name", gap = 1 }, -- <- shows “Method/Function/Snippet”, plus source (LSP/snippets/etc.)
          },

          -- optional tweaks (nice but not required)
          components = {
            kind_icon = {
              -- small spacer after the icon
              text = function(ctx)
                return (ctx.kind_icon or "") .. (ctx.icon_gap or " ")
              end,
            },
            kind = {
              -- render the textual kind
              text = function(ctx)
                return ctx.kind or ""
              end,
              highlight = "BlinkCmpKind", -- uses blink’s kind highlights
            },
            source_name = {
              text = function(ctx)
                return ctx.source_name or ""
              end,
              highlight = "Comment",
            },
          },
        },
      },
    },
    cmdline = {
      enabled = false,
    },
    sources = {
      default = { "lsp", "snippets", "path", "buffer", "codecompanion" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
      },
      per_filetype = {
        codecompanion = { "codecompanion" },
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
