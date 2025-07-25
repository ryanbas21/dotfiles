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
      version = "v2.*",
      build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
      dependencies = {
        "mrcjkb/haskell-snippets.nvim",
        "rafamadriz/friendly-snippets",
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
    -- Performance improvements
    fuzzy = {
      use_frecency = true,
      use_proximity = true,
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono", -- Better icon alignment
      kind_icons = {
        Copilot = "",
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
      window = {
        border = "single",
        show_documentation = true,
        treesitter_highlighting = true,
      },
    },

    completion = {
      keyword = {
        range = "prefix", -- More precise matching
      },
      trigger = {
        prefetch_on_insert = true, -- Better performance
        show_on_backspace = true, -- More intuitive
        show_on_backspace_in_keyword = true,
        show_on_backspace_after_accept = true,
        show_on_insert = false, -- Less intrusive
      },
      accept = {
        auto_brackets = {
          enabled = true, -- Auto-insert function brackets
        },
        create_undo_point = true, -- Better undo behavior
      },
      list = {
        max_items = 200,
        selection = {
          preselect = true,
          auto_insert = false, -- More predictable behavior
        },
      },
      menu = {
        border = "single",
        winblend = 0,
        scrolloff = 2,
        draw = {
          treesitter = { "lsp" },
          -- Show kind icon, label with description, and kind text
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 150, -- Faster than default
        update_delay_ms = 50, -- Smoother updates
        treesitter_highlighting = true,
        window = {
          border = "single",
          max_width = 80,
          max_height = 20,
        },
      },
      ghost_text = {
        enabled = true,
      },
    },

    -- Enhanced cmdline support
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      sources = { "buffer", "cmdline" },
      completion = {
        menu = {
          auto_show = function(ctx, _)
            return ctx.mode == "cmdwin"
          end,
        },
        ghost_text = { enabled = true },
      },
    },

    sources = {
      default = { "lsp", "snippets", "path", "buffer", "codecompanion" },
      providers = {
        lsp = {
          fallbacks = { "buffer" },
        },
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
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
        path = {
          score_offset = 3,
          opts = {
            trailing_slash = true,
            show_hidden_files_by_default = false,
          },
        },
        buffer = {
          score_offset = -3,
          opts = {
            max_total_buffer_size = 1000000, -- 1MB
            use_cache = true, -- Better performance
          },
        },
        snippets = {
          score_offset = -1,
        },
      },
      per_filetype = {
        codecompanion = { "codecompanion" },
        lua = { "lsp", "snippets", "path", "buffer" }, -- Lua-specific
        markdown = { "lsp", "snippets", "path", "buffer" }, -- Markdown-specific
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

      -- Additional useful keymaps
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
  },
}
