# nvf settings for homeConfigurations.ryan
#
# Ports the previous lazy.nvim + mason setup to nvf (pinned v26.07):
#   - lazy.nvim is replaced by nvf's lz.n loader (`vim.lazy.plugins`)
#   - mason is replaced by Nix-provided binaries (`vim.extraPackages`)
#   - nvim-treesitter is owned by nvf's treesitter module (all grammars)
#   - the user's core lua (options/mappings/autocmds) and the native
#     `vim.lsp.enable` lsp/*.lua files are sourced from ../nvim/.config/nvim
#
# The only edits to existing lua files are the two mason-path fixes in
# lsp/eslint.lua and lsp/elixirls.lua (bare command names now resolved
# from PATH).
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;

  vp = pkgs.vimPlugins;

  # The existing (stowed) nvim config, imported to the store.
  nvimCfg = ../nvim/.config/nvim;

  lspServers = [
    "angularls"
    "bashls"
    "clojure_lsp"
    "cssls"
    "diagnosticls"
    "dprint"
    "elixirls"
    "eslint"
    "gleam"
    "gopls"
    "hls"
    "html"
    "jdtls"
    "jsonls"
    "lua_ls"
    "marksman"
    "ocamllsp"
    "prismals"
    "purescriptls"
    "rescript"
    "rust_analyzer"
    "stylelint_lsp"
    "svelte"
    "tailwindcss"
    "tsgo"
    "yamlls"
  ];

  # Plugins missing from nixpkgs vimPlugins, built from the commits pinned
  # in the old lazy-lock.json.
  pinned = {
    pname,
    owner,
    repo,
    rev,
    hash,
  }:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname;
      version = builtins.substring 0 7 rev;
      doCheck = false;
      src = pkgs.fetchFromGitHub {inherit owner repo rev hash;};
    };

  schemastore-nvim = pinned {
    pname = "schemastore-nvim";
    owner = "b0o";
    repo = "schemastore.nvim";
    rev = "e954496f8ef22904e8a84f5078f4a110fdc7a0d3"; # lazy-lock.json
    hash = "sha256-b8HOclkr3FoCNUDJ6f0ULsfyiQB38+9PNxl0CibVL60=";
  };

  vim-rescript = pinned {
    pname = "vim-rescript";
    owner = "rescript-lang";
    repo = "vim-rescript";
    rev = "ed9e678862815609fe40abb23c66919c16455574"; # lazy-lock.json
    hash = "sha256-LCIcxsE4fJ2DnQN2inzoKsnoKfBF2ktr4Bt8hrT0gts=";
  };

  ts-error-translator-nvim = pinned {
    pname = "ts-error-translator-nvim";
    owner = "dmmulroy";
    repo = "ts-error-translator.nvim";
    rev = "558abff11b9e8f4cefc0de09df780c56841c7a4b"; # lazy-lock.json
    hash = "sha256-kjZwfvb0B7GC4dBBSdgC/zRmCUCfCm4H5J+8SFzANJ4=";
  };
in {
  vim = {
    viAlias = true;
    vimAlias = true;

    # Don't let nvf inject its own default keymaps; the user's mappings.lua
    # and the ported plugin specs own all keybindings.
    vendoredKeymaps.enable = false;

    # Expose the existing nvim config dir on the runtimepath (prepended so
    # its lsp/*.lua win over nvim-lspconfig's). NVIM_APPNAME=nvf, so there
    # is no stdpath collision. Makes require("configs..."), require("lsp...")
    # style modules resolve.
    additionalRuntimePaths = [
      {
        path = nvimCfg;
        position = "prepend";
      }
    ];

    # Core lua, sourced as-is at the end of startup (init.lua used to do
    # this in a vim.schedule). init.lua itself is NOT sourced: it bootstraps
    # lazy.nvim and prepends mason to PATH — both retired.
    extraLuaFiles = [
      (nvimCfg + "/lua/options.lua")
      (nvimCfg + "/lua/mappings.lua")
      (nvimCfg + "/lua/autocmds.lua")
    ];

    ########################################################################
    # Treesitter — owned by nvf. Main-branch semantics, all grammars from
    # Nix. The old treesitter plugin spec is intentionally not ported.
    ########################################################################
    treesitter = {
      enable = true;
      grammars = vp.nvim-treesitter.allGrammars;
      highlight.enable = true;
      # the old spec only enabled highlight; keep behavior
      indent.enable = false;
      fold = false;
    };

    ########################################################################
    # Theme — catppuccin via nvf's theme module (old spec had no opts,
    # i.e. defaults). Note: onedarkpro (ported below, eager, as before)
    # still wins at runtime via its `colorscheme onedark` — same as today.
    ########################################################################
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    ########################################################################
    # LSP plumbing. nvf's lsp module is enabled only to host the
    # lightbulb/lspkind/trouble plugin modules; the actual server configs
    # are the user's own lsp/*.lua files driven by the native
    # `vim.lsp.enable` API (sourced from the nvim-lspconfig entry below,
    # same as configs/lsp/handlers.lua has always done).
    ########################################################################
    lsp = {
      enable = true;
      formatOnSave = false;
      inlayHints.enable = false;

      lightbulb = {
        enable = true;
        autocmd.enable = true;
        setupOpts = {
          sign.enabled = false;
          virtual_text = {
            enabled = true;
            text = "";
          };
        };
      };

      trouble = {
        enable = true;
        setupOpts.modes.preview_float = {
          mode = "diagnostics";
          preview = {
            type = "float";
            relative = "editor";
            border = "rounded";
            title = "Preview";
            title_pos = "center";
            position = [0 (-2)];
            size = {
              width = 0.3;
              height = 0.3;
            };
            zindex = 200;
          };
        };
      };
    };

    ########################################################################
    # Modules for plugins with clean nvf coverage
    ########################################################################
    autopairs.nvim-autopairs = {
      enable = true;
      setupOpts.check_ts = true;
    };

    utility.surround.enable = true;

    git = {
      gitsigns.enable = true;
      git-conflict.enable = true;
      neogit = {
        enable = true;
        setupOpts.integrations.diffview = true;
      };
    };

    utility.diffview-nvim = {
      enable = true;
      setupOpts.default_args.DiffviewOpen = [];
    };

    statusline.lualine = {
      enable = true;
      setupOpts = {
        options = {
          icons_enabled = true;
          theme = "auto";
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
          disabled_filetypes = {
            statusline = [];
            winbar = [];
          };
          ignore_focus = [];
          always_divide_middle = true;
          always_show_tabline = true;
          globalstatus = false;
          refresh = {
            statusline = 100;
            tabline = 100;
            winbar = 100;
          };
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff"];
          lualine_c = ["filename"];
          lualine_x = ["diagnostics" "encoding" "fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
        inactive_sections = {
          lualine_a = [];
          lualine_b = [];
          lualine_c = ["filename"];
          lualine_x = ["location"];
          lualine_y = [];
          lualine_z = [];
        };
        tabline = {};
        winbar = {};
        inactive_winbar = {};
        extensions = lib.mkForce []; # exact port of the old spec (nvf wanted to add a snacks picker extension)
      };
    };

    binds.whichKey = {
      enable = true;
      setupOpts = {};
    };

    snippets.luasnip = {
      enable = true;
      providers = ["friendly-snippets"];
      # verbatim from the old LuaSnip spec
      loaders = ''
        require('luasnip.loaders.from_snipmate').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load()
      '';
    };

    terminal.toggleterm = {
      enable = true;
      setupOpts = {
        size = 20;
        open_mapping = "[[<c-\\>]]";
        hide_numbers = true;
        shade_terminals = true;
        start_in_insert = true;
        insert_mappings = true;
        terminal_mappings = true;
        persist_size = true;
        direction = "float";
        close_on_exit = true;
        shell = mkLuaInline "vim.o.shell";
        float_opts = {
          border = "curved";
          winblend = 0;
        };
      };
    };

    ui.noice = {
      enable = true;
      setupOpts = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };
      };
    };

    notify.nvim-notify.enable = true;

    visuals = {
      fidget-nvim.enable = true;
      nvim-web-devicons.enable = true;
    };

    formatter.conform-nvim = {
      enable = true;
      setupOpts =
        {
          # verbatim formatters_by_ft from the old conform spec
          formatters_by_ft = {
            nix = ["nixpkgs-fmt"];
            lua = ["luaformatter" "stylua"];
            css = ["prettierd"];
            elm = ["elm_format"];
            ocaml = ["ocamlformat"];
            gleam = ["gleam format"];
            yaml = ["yamlfix"];
            markdown = ["mdformat"];
            haskell = ["ormolu"];
            html = ["prettierd" "prettier" "biome"];
            typescript = ["eslint_d" "dprint" "prettierd" "biome"];
            javascript = ["eslint_d" "dprint" "prettierd" "biome"];
            typescriptreact = ["prettierd" "biome"];
            json = ["eslint_d" "prettierd"];
            javascriptreact = ["prettierd" "biome"];
            purescript = ["purs-tidy"];
            luals = ["stylua"];
            "_" = ["trim_whitespace"];
          };
        }
        // {
          # format_on_save is a function in the spec; pass it verbatim
          format_on_save = mkLuaInline ''
            function(bufnr)
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              -- Skip formatting for package.json — LSP formatters can restore
              -- deleted dependencies due to stale document state on save.
              if bufname:match "package%.json$" then
                return false
              end
              return {
                timeout_ms = 500,
                lsp_format = "fallback",
              }
            end
          '';
        };
    };

    diagnostics.nvim-lint = {
      enable = true;
      # verbatim lintlers_by_ft from the old nvim-lint spec
      linters_by_ft = {
        javascript = ["eslint_d"];
        typescript = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        haskell = ["hlint"];
        angular = ["eslint_d"];
        bash = ["bash"];
        git = ["gitlint"];
        json = ["jsonlint" "eslint_d"];
        yaml = ["yamllint"];
        python = ["ruff"];
        eslint_d = ["eslint_d"];
        lua = ["luacheck"];
        css = ["stylelint"];
      };
      # the user's autocmds.lua already lints on BufWritePost/InsertLeave/BufEnter
      lint_after_save = false;
    };

    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile.enabled = true;
        dashboard.enabled = true;
        explorer = {
          enabled = true;
          replace_netrw = true;
        };
        indent.enabled = true;
        input.enabled = true;
        picker.enabled = true;
        rename.enabled = false;
        notifier.enabled = true;
        quickfile.enabled = true;
        scope.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = true;
        words.enabled = true;
        zen.enabled = false;
      };
    };

    ########################################################################
    # Lazy-loaded plugins (lz.n) — triggers and configs ported verbatim
    # from lua/plugins/*.lua
    ########################################################################
    lazy.plugins = {
      # ---- nvim-lspconfig: sources handlers.lua (on_attach, diagnostics,
      # capabilities) and enables the user's lsp/*.lua servers natively.
      "${vp.nvim-lspconfig.pname}" = {
        package = vp.nvim-lspconfig;
        event = "BufReadPre";
        after = ''
          dofile("${nvimCfg + "/lua/configs/lsp/handlers.lua"}")
          -- handlers.lua discovers servers via stdpath("config")/lsp, which
          -- does not exist under NVIM_APPNAME=nvf; enable them explicitly.
          -- Configs resolve from the prepended runtimepath above.
          vim.lsp.enable({${lib.concatStringsSep ", " (map (s: "\"" + s + "\"") lspServers)}})
        '';
      };

      # ---- blink.cmp (spec opts kept verbatim, including lua functions;
      # nvf's blink module is not used because its forced sources/keymap
      # defaults would alter the spec)
      "${vp.blink-cmp.pname}" = {
        package = vp.blink-cmp;
        event = "InsertEnter";
        setupModule = "blink";
        setupOpts = mkLuaInline ''
          {
            appearance = {
              use_nvim_cmp_as_default = false,
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
              trigger = {
                enabled = true,
                show_on_insert = true,
              },
              window = {
                show_documentation = true,
              },
            },
            completion = {
              documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
              },
              menu = {
                draw = {
                  treesitter = { "lsp" },
                  columns = {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "kind", "source_name", gap = 1 },
                  },
                  components = {
                    kind_icon = {
                      text = function(ctx)
                        return (ctx.kind_icon or "") .. (ctx.icon_gap or " ")
                      end,
                    },
                    kind = {
                      text = function(ctx)
                        return ctx.kind or ""
                      end,
                      highlight = "BlinkCmpKind",
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
                lsp = {
                  score_offset = 100,
                  async = true,
                },
                snippets = {
                  score_offset = 50,
                  should_show_items = function(ctx)
                    return ctx.trigger.initial_kind ~= "trigger_character"
                  end,
                },
                buffer = {
                  score_offset = -50,
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
              ["<CR>"] = {
                function(cmp)
                  if cmp.is_visible() then
                    return cmp.select_and_accept()
                  end

                  if vim.fn.pumvisible() == 1 then
                    return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
                  end
                end,
                "fallback",
              },
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
          }
        '';
      };

      # ---- codecompanion
      "${vp.codecompanion-nvim.pname}" = {
        package = vp.codecompanion-nvim;
        before = ''
          require("configs.codecompanion.spinner"):init()
        '';
        setupModule = "codecompanion";
        setupOpts = mkLuaInline ''
          {
            extensions = {
              mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                  show_result_in_chat = true,
                  make_vars = false,
                  make_slash_commands = true,
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
          }
        '';
        keys = [
          {
            key = "<leader>cc;";
            mode = ["n" "v"];
            action = "function() require('codecompanion').toggle() end";
            lua = true;
            desc = "AI: Toggle chat buffer";
          }
          {
            key = "<leader>al";
            mode = ["n" "v"];
            action = "function() require('codecompanion').prompt 'lsp' end";
            lua = true;
            desc = "AI: Explain LSP diagnostics";
          }
          {
            key = "<leader>ai";
            mode = ["n" "v"];
            action = "function() require('codecompanion').prompt 'inline' end";
            lua = true;
            desc = "AI: Inline";
          }
          {
            key = "<leader>ae";
            mode = "v";
            action = "function() require('codecompanion').prompt 'expert' end";
            lua = true;
            desc = "AI: Explain snippet";
          }
          {
            key = "<leader>af";
            mode = "v";
            action = "function() require('codecompanion').prompt 'fix' end";
            lua = true;
            desc = "AI: Fix snippet";
          }
          {
            key = "<leader>cct";
            mode = "n";
            action = "function() require('codecompanion').prompt 'test' end";
            lua = true;
            desc = "Run test AI workflow";
          }
        ];
      };

      # ---- haskell-tools (was lazy=false)
      "${vp.haskell-tools-nvim.pname}" = {
        package = vp.haskell-tools-nvim;
        lazy = false;
      };

      # ---- hover.nvim
      "${vp.hover-nvim.pname}" = {
        package = vp.hover-nvim;
        keys = [
          {
            key = "K";
            mode = "n";
            action = "function() require('hover').hover() end";
            lua = true;
            desc = "hover.nvim";
          }
          {
            key = "gK";
            mode = "n";
            action = "function() require('hover').hover_select() end";
            lua = true;
            desc = "hover select provider";
          }
          {
            key = "<C-p>";
            mode = "n";
            action = "function() require('hover').hover_switch 'previous' end";
            lua = true;
            desc = "hover previous provider";
          }
          {
            key = "<C-y>";
            mode = "n";
            action = "function() require('hover').hover_switch 'next' end";
            lua = true;
            desc = "hover next provider";
          }
          {
            key = "<MouseMove>";
            mode = "n";
            action = ''
              function()
                vim.o.mousemoveevent = true
                require('hover').hover_mouse {}
              end
            '';
            lua = true;
            desc = "hover mouse move";
          }
        ];
        after = ''
          require("hover").setup {
            init = function()
              -- Require providers
              require "hover.providers.lsp"
              require "hover.providers.gh"
              require "hover.providers.gh_user"
              -- require "hover.providers.jira"
              -- require "hover.providers.dap"
              require "hover.providers.fold_preview"
              require "hover.providers.diagnostic"
              -- require "hover.providers.man"
              require "hover.providers.dictionary"
            end,
            preview_opts = {
              border = "single",
            },
            preview_window = true,
            title = true,
            mouse_providers = {
              "LSP",
            },
            mouse_delay = 1000,
          }
        '';
      };

      # ---- inc-rename
      "${vp.inc-rename-nvim.pname}" = {
        package = vp.inc-rename-nvim;
        event = "LspAttach";
        keys = [
          {
            key = "<leader>rn";
            mode = "n";
            action = ":IncRename ";
            desc = "Rename under cursor";
          }
        ];
        after = ''
          require("inc_rename").setup {}
        '';
      };

      # ---- mcphub (mcp-hub binary is not in nixpkgs — gap; cmd-gated so it
      # only fails when actually opened)
      "${vp.mcphub-nvim.pname}" = {
        package = vp.mcphub-nvim;
        cmd = "MCPHub";
        after = ''
          require("mcphub").setup {
            auto_approve = true,
            config = vim.fn.expand "~/.config/mcphub/servers.json",
            use_bundled_binary = true,
            port = 37373,
            shutdown_delay = 60 * 10 * 000,
            mcp_request_timeout = 60000,
          }
        '';
      };

      # ---- neotest
      "${vp.neotest.pname}" = {
        package = vp.neotest;
        cmd = "Neotest";
        after = ''
          -- HACK: fix for nvim_create_augroup must not be called in a fast event context
          -- see: https://github.com/nvim-neotest/neotest/issues/351
          pcall(vim.treesitter.language.get_parser, "typescript")

          require("neotest").setup {
            status = {
              virtual_text = true,
              signs = true,
            },
            icons = {
              expanded = "";
              child_prefix = "";
              child_indent = "";
              final_child_prefix = "";
              non_collapsible = "";
              collapsed = "";
              passed = "";
              running = "";
              failed = "";
              unknown = "";
            },
            quickfix = {
              open = function()
                vim.cmd "Trouble quickfix"
              end,
              enabled = false,
            },
            adapters = {
              require "neotest-haskell" {
                build_tools = { "stack", "cabal" },
                frameworks = { "tasty", "hspec", "sydtest" },
              },
              require "neotest-vitest" {
                env = { CI = true },
                filter_dir = function(name, rel_path, root)
                  return name ~= "node_modules"
                end,
              },
              require "neotest-elixir",
              require "neotest-jest" {},
              require("neotest-playwright").adapter {
                options = {
                  persist_project_selection = true,
                  enable_dynamic_test_discovery = true,
                  preset = "none",
                  experimental = {
                    telescope = {
                      enabled = false,
                    },
                  },
                },
              },
            },
          }
        '';
        keys = [
          {
            key = "<leader>tf";
            mode = "n";
            action = ''function() require("neotest").run.run(vim.fn.expand "%") end'';
            lua = true;
            desc = "Run File";
          }
          {
            key = "<leader>tt";
            mode = "n";
            action = ''function() require("neotest").run.run(vim.uv.cwd()) end'';
            lua = true;
            desc = "Run All Test Files";
          }
          {
            key = "<leader>tr";
            mode = "n";
            action = ''function() require("neotest").run.run() end'';
            lua = true;
            desc = "Run Nearest";
          }
          {
            key = "<leader>tl";
            mode = "n";
            action = ''function() require("neotest").run.run_last() end'';
            lua = true;
            desc = "Run Last";
          }
          {
            key = "<leader>ts";
            mode = "n";
            action = ''function() require("neotest").summary.toggle() end'';
            lua = true;
            desc = "Toggle Summary";
          }
          {
            key = "<leader>to";
            mode = "n";
            action = ''function() require("neotest").output.open { enter = true, auto_close = true } end'';
            lua = true;
            desc = "Show Output";
          }
          {
            key = "<leader>tO";
            mode = "n";
            action = ''function() require("neotest").output_panel.toggle() end'';
            lua = true;
            desc = "Toggle Output Panel";
          }
          {
            key = "<leader>tS";
            mode = "n";
            action = ''function() require("neotest").run.stop() end'';
            lua = true;
            desc = "Stop";
          }
          {
            key = "<leader>tw";
            mode = "n";
            action = ''function() require("neotest").watch.toggle(vim.fn.expand "%") end'';
            lua = true;
            desc = "Toggle Watch";
          }
        ];
      };

      # ---- nvim-ufo
      "${vp.nvim-ufo.pname}" = {
        package = vp.nvim-ufo;
        event = "BufRead";
        keys = [
          {
            key = "zR";
            mode = "n";
            action = "function() require('ufo').openAllFolds() end";
            lua = true;
          }
          {
            key = "zM";
            mode = "n";
            action = "function() require('ufo').closeAllFolds() end";
            lua = true;
          }
        ];
        after = ''
          vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
          vim.o.foldcolumn = "0"
          vim.o.foldlevel = 99
          vim.o.foldlevelstart = 100
          vim.o.foldenable = true
          local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (" 󰁂 %d "):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
              else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                end
                break
              end
              curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
          end

          require("ufo").setup {
            fold_virt_text_handler = handler,
            close_fold_kinds_for_ft = {
              default = { "imports", "comment" },
              json = { "array" },
              c = { "comment", "region" },
            },
          }
        '';
      };

      # ---- onedarkpro (was lazy=false, priority 999; `make extras` build
      # step skipped — the default themes are in the repo)
      "${vp.onedarkpro-nvim.pname}" = {
        package = vp.onedarkpro-nvim;
        lazy = false;
        priority = 999;
        setupModule = "onedarkpro";
        setupOpts = mkLuaInline ''
          {
            colors = {
              vaporwave = {
                codeblock = "require('onedarkpro.helpers').lighten('bg', 2, 'vaporwave')",
                statusline_bg = "require('onedarkpro.helpers').lighten('bg', 4, 'vaporwave')",
                statuscolumn_border = "require('onedarkpro.helpers').lighten('bg', 4, 'vaporwave')",
                ellipsis = "require('onedarkpro.helpers').lighten('bg', 4, 'vaporwave')",
                picker_results = "require('onedarkpro.helpers').darken('bg', 4, 'vaporwave')",
                picker_selection = "require('onedarkpro.helpers').darken('bg', 8, 'vaporwave')",
                copilot = "require('onedarkpro.helpers').darken('gray', 8, 'vaporwave')",
                breadcrumbs = "require('onedarkpro.helpers').darken('gray', 10, 'vaporwave')",
                light_gray = "require('onedarkpro.helpers').darken('gray', 7, 'vaporwave')",
              },
              onedark = {
                codeblock = "require('onedarkpro.helpers').lighten('bg', 2, 'onedark')",
                statusline_bg = "#2e323b",
                statuscolumn_border = "#4b5160",
                ellipsis = "#808080",
                picker_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')",
                picker_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
                copilot = "require('onedarkpro.helpers').darken('gray', 8, 'onedark')",
                breadcrumbs = "require('onedarkpro.helpers').darken('gray', 10, 'onedark')",
                light_gray = "require('onedarkpro.helpers').darken('gray', 7, 'onedark')",
              },
              light = {
                codeblock = "require('onedarkpro.helpers').darken('bg', 3, 'onelight')",
                comment = "#bebebe",
                statusline_bg = "#f0f0f0",
                statuscolumn_border = "#e7e7e7",
                ellipsis = "#808080",
                git_add = "require('onedarkpro.helpers').get_preloaded_colors('onelight').green",
                git_change = "require('onedarkpro.helpers').get_preloaded_colors('onelight').yellow",
                git_delete = "require('onedarkpro.helpers').get_preloaded_colors('onelight').red",
                picker_results = "require('onedarkpro.helpers').darken('bg', 5, 'onelight')",
                picker_selection = "require('onedarkpro.helpers').darken('bg', 9, 'onelight')",
                copilot = "require('onedarkpro.helpers').lighten('gray', 8, 'onelight')",
                breadcrumbs = "require('onedarkpro.helpers').lighten('gray', 8, 'onelight')",
                light_gray = "require('onedarkpro.helpers').lighten('gray', 10, 'onelight')",
              },
              rainbow = {
                "''${green}",
                "''${blue}",
                "''${purple}",
                "''${red}",
                "''${orange}",
                "''${yellow}",
                "''${cyan}",
              },
            },
            highlights = {
              CodeCompanionChatIcon = { fg = "''${green}" },
              CodeCompanionChatToolFailure = { fg = "''${gray}", italic = true },
              CodeCompanionChatToolSuccess = { fg = "''${gray}", bg = "NONE", italic = true },
              CodeCompanionTokens = { fg = "''${gray}", italic = true },
              CodeCompanionVirtualText = { fg = "''${gray}", italic = true },
              ["@markup.quote.markdown"] = { italic = true, extend = true },
              EdgyNormal = { bg = "''${bg}" },
              EdgyTitle = { fg = "''${purple}", bold = true },
              EyelinerPrimary = { fg = "''${green}" },
              EyelinerSecondary = { fg = "''${blue}" },
              NormalFloat = { bg = "''${bg}" },
              FloatBorder = { fg = "''${gray}", bg = "''${bg}" },
              CursorLineNr = { bg = "''${bg}", fg = "''${fg}", italic = true },
              MatchParen = { fg = "''${cyan}" },
              ModeMsg = { fg = "''${gray}" },
              Search = { bg = "''${selection}", fg = "''${yellow}", underline = true },
              VimLogo = { fg = { dark = "#81b766", light = "#029632" } },
              SnacksDashboardDesc = { fg = "''${blue}", bold = true },
              SnacksDashboardKey = { fg = "''${orange}", bold = true, italic = true },
              SnacksDashboardIcon = { fg = "''${blue}" },
              DebugBreakpoint = { fg = "''${red}", italic = true },
              DebugHighlightLine = { fg = "''${purple}", italic = true },
              NvimDapVirtualText = { fg = "''${cyan}", italic = true },
              LuaSnipChoiceNode = { fg = "''${yellow}" },
              LuaSnipInsertNode = { fg = "''${yellow}" },
              NeotestAdapterName = { fg = "''${purple}", bold = true },
              NeotestFocused = { bold = true },
              NeotestNamespace = { fg = "''${blue}", bold = true },
              UfoFoldedEllipsis = { fg = "''${yellow}" },
              SnacksPickerDir = { fg = "''${gray}", italic = true },
              SnacksPickerPreview = { bg = "''${bg}" },
              SnacksPickerPreviewBorder = { fg = "''${bg}", bg = "''${bg}" },
              SnacksPickerPreviewTitle = { bg = "''${green}", fg = "''${bg}", bold = true },
            },
            caching = false,
            cache_path = vim.fn.expand(vim.fn.stdpath "cache" .. "/onedarkpro_dotfiles"),
            plugins = {
              barbar = false,
              lsp_saga = false,
              marks = false,
              polygot = false,
              startify = false,
              telescope = false,
              trouble = false,
              vim_ultest = false,
              which_key = false,
            },
            styles = {
              tags = "italic",
              methods = "bold",
              functions = "bold",
              keywords = "italic",
              comments = "italic",
              parameters = "italic",
              conditionals = "italic",
              virtual_text = "italic",
            },
            options = {
              cursorline = true,
            },
          }
        '';
        after = ''
          vim.cmd.colorscheme "onedark"
        '';
      };

      # ---- overseer
      "${vp.overseer-nvim.pname}" = {
        package = vp.overseer-nvim;
        setupModule = "overseer";
        setupOpts = {
          templates = ["builtin" "vscode"];
          strategy = {
            "toggleterm" = {
              use_shell = false;
              direction = null;
              highlights = null;
              auto_scroll = null;
              close_on_exit = false;
              quit_on_exit = "never";
              open_on_start = true;
              hidden = false;
              on_create = null;
            };
          };
        };
        keys = [
          {
            key = "<D-r>";
            mode = "n";
            action = "<cmd>OverseerRun<cr>";
            desc = "Run Task";
          }
          {
            key = "<D-S-r>";
            mode = "n";
            action = "<cmd>OverseerToggle<cr>";
            desc = "Toggle Task List";
          }
        ];
      };

      # ---- package-info (setupOpts taken from the spec's `opt` table — the
      # spec's `opts` key was a typo, so the table was never applied before)
      "${vp.package-info-nvim.pname}" = {
        package = vp.package-info-nvim;
        ft = "json";
        setupModule = "package-info";
        setupOpts = {
          colors = {
            up_to_date = "#3C4048";
            outdated = "#d19a66";
            invalid = "#ee4b2b";
          };
          icons = {
            enable = true;
            style = {
              up_to_date = "|  ";
              outdated = "|  ";
              invalid = "|  ";
            };
          };
          autostart = true;
          hide_up_to_date = true;
          hide_unstable_versions = false;
          package_manager = "pnpm";
        };
        keys = [
          {
            key = "<leader>pi";
            mode = "n";
            action = "<cmd>lua require('package-info').install()<CR>";
            desc = "Packages install";
          }
          {
            key = "<leader>pp";
            mode = "n";
            action = "<cmd>lua require('package-info').change_version()<CR>";
            desc = "Packages change version";
          }
          {
            key = "<LEADER>pt";
            mode = "n";
            action = "<cmd>lua require('package-info').toggle()<CR>";
            desc = "Packages toggle";
          }
          {
            key = "<LEADER>pu";
            mode = "n";
            action = "<cmd>lua require('package-info').update()<CR>";
            desc = "Packages update";
          }
          {
            key = "<LEADER>pd";
            mode = "n";
            action = "<cmd>lua require('package-info').delete()<CR>";
            desc = "Packages delete";
          }
        ];
      };

      # ---- markview (was lazy=false)
      "${vp.markview-nvim.pname}" = {
        package = vp.markview-nvim;
        lazy = false;
      };

      # ---- canola (oil fork; was lazy=false, loads require("oil"))
      "${vp.canola-nvim.pname}" = {
        package = vp.canola-nvim;
        lazy = false;
        keys = [
          {
            key = "-";
            mode = "n";
            action = "function() require('oil').open_float() end";
            lua = true;
            desc = "Open Oil Directory";
          }
        ];
        after = ''
          require("oil").setup({
            default_file_explorer = false,
            keymaps = {
              ["g?"] = { "actions.show_help", mode = "n" },
              ["<CR>"] = "actions.select",
              ["<C-s>"] = { "actions.select", opts = { vertical = true } },
              ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
              ["<C-t>"] = { "actions.select", opts = { tab = true } },
              ["<C-p>"] = "actions.preview",
              ["<C-c>"] = { "actions.close", mode = "n" },
              ["C-q"] = { "actions.close", mode = "n" },
              ["<C-l>"] = "actions.refresh",
              ["_"] = { "actions.open_cwd", mode = "n" },
              ["`"] = { "actions.cd", mode = "n" },
              ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
              ["gs"] = { "actions.change_sort", mode = "n" },
              ["gx"] = "actions.open_external",
              ["g."] = { "actions.toggle_hidden", mode = "n" },
              ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
          })
        '';
      };

      # ---- leetcode (nvf's leetcode module is not used: it forces
      # telescope.nvim, which this config does not use)
      "leetcode-nvim" = {
        package = "leetcode-nvim";
        cmd = "Leet";
        setupModule = "leetcode";
        setupOpts = {
          arg = "leetcode.nvim";
          lang = "python3";
        };
      };

      # ---- treesitter endwise (no config in the original spec either)
      "${vp.nvim-treesitter-endwise.pname}" = {
        package = vp.nvim-treesitter-endwise;
        event = "InsertEnter";
      };

      # ---- ts-error-translator (ft-triggered, no config in the spec)
      "${ts-error-translator-nvim.pname}" = {
        package = ts-error-translator-nvim;
        ft = ["ts" "typescript" "typescriptreact"];
      };

      # ---- ghcid (its nvim plugin lives at <pkg>/plugins/nvim in the repo)
      "${vp.ghcid.pname}" = {
        package = vp.ghcid;
        cmd = "Ghcid";
        ft = ["haskell"];
        after = ''
          vim.opt.rtp:append("${vp.ghcid}/plugins/nvim")
        '';
      };

      # ---- vim-repeat (was event BufEnter)
      "vim-repeat" = {
        package = "vim-repeat";
        event = "BufEnter";
      };
    };

    ########################################################################
    # Eager plugins without their own trigger/setup (libraries & deps)
    ########################################################################
    extraPlugins = {
      nui-nvim.package = vp.nui-nvim;
      nvim-nio.package = vp.nvim-nio;
      promise-async.package = vp.promise-async;
      FixCursorHold-nvim.package = vp.FixCursorHold-nvim;
      # lspkind: only a blink.cmp dependency in the old spec (never set up)
      lspkind-nvim.package = vp.lspkind-nvim;
      haskell-snippets-nvim.package = vp.haskell-snippets-nvim;
      # blink sources available for opt-in (deps of the old blink spec)
      blink-emoji-nvim.package = vp.blink-emoji-nvim;
      blink-cmp-dictionary.package = vp.blink-cmp-dictionary;
      # neotest adapters (deps of the old neotest spec)
      neotest-elixir.package = vp.neotest-elixir;
      neotest-haskell.package = vp.neotest-haskell;
      neotest-jest.package = vp.neotest-jest;
      neotest-playwright.package = vp.neotest-playwright;
      neotest-vitest.package = vp.neotest-vitest;
      # eager on purpose: lsp/*.lua resolve require("schemastore") when a
      # server config loads (jsonls/yamlls), which can precede any LspAttach
      schemastore-nvim.package = schemastore-nvim;
      # plain filetype/syntax plugin, eagerly on rtp as before
      vim-rescript.package = vim-rescript;
    };

    ########################################################################
    # Tool binaries (mason retirement) — resolved from PATH via the mnw
    # wrapper. Gaps (not in nixpkgs, left PATH-resolved): mcp-hub,
    # purescript-language-server, purs-tidy, jsonlint, sonarlint (n/a).
    ########################################################################
    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      typescript-language-server
      typescript-go # tsgo fallback; the lsp/tsgo.lua config prefers local node_modules
      vscode-langservers-extracted # json/html/css/eslint servers
      tailwindcss-language-server
      svelte-language-server
      gopls
      rust-analyzer
      bash-language-server
      clojure-lsp
      elixir-ls
      gleam
      jdt-language-server
      marksman
      ocamlPackages.ocaml-lsp
      yaml-language-server
      angular-language-server
      haskell-language-server
      prisma-language-server
      rescript-language-server
      stylelint-lsp
      diagnostic-languageserver
      dprint

      # formatters
      prettierd
      stylua
      luaformatter
      biome
      elmPackages.elm-format
      ocamlformat
      yamlfix
      mdformat
      ormolu
      nixpkgs-fmt
      eslint_d

      # linters
      hlint
      gitlint
      yamllint
      ruff
      luajitPackages.luacheck
      stylelint
      actionlint

      # misc tooling used by plugins
      git
      ghcid
    ];

    ########################################################################
    # Extra keymaps ported from specs whose plugins are eager or
    # module-loaded
    ########################################################################
    keymaps = [
      # which-key <leader>?
      {
        mode = "n";
        key = "<leader>?";
        action = "function() require('which-key').show { global = false } end";
        lua = true;
        desc = "Buffer Local Keymaps (which-key)";
      }
      # snacks.nvim
      {
        mode = "n";
        key = "<C-n>";
        action = "function() Snacks.explorer.open() end";
        lua = true;
        desc = "Explorer";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "function() Snacks.picker.files() end";
        lua = true;
        desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader><leader>";
        action = "function() Snacks.picker.git_files() end";
        lua = true;
        desc = "Git files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "function() Snacks.picker.grep() end";
        lua = true;
        desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "function() Snacks.picker.buffers() end";
        lua = true;
        desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>;";
        action = "function() Snacks.picker.lines() end";
        lua = true;
        desc = "Buffer lines";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "function() Snacks.picker.help() end";
        lua = true;
        desc = "Help";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "function() Snacks.picker.recent() end";
        lua = true;
        desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "function() Snacks.picker.git_log() end";
        lua = true;
        desc = "Git commits";
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "function() Snacks.picker.colorschemes() end";
        lua = true;
        desc = "Colorschemes";
      }
      # trouble
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        desc = "LSP Definitions / references / ... (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>qf";
        action = "<cmd>Trouble qflist toggle<cr>";
        desc = "Quickfix List (Trouble)";
      }
      # diffview
      {
        mode = "n";
        key = "<leader>pr";
        action = ":DiffviewOpen origin/main...HEAD --imply-local<CR>";
        desc = "Review PR / branch";
      }
      {
        mode = "n";
        key = "dv";
        action = ":DiffviewOpen<CR>";
        desc = "Open Diffview";
      }
      {
        mode = "n";
        key = "dc";
        action = ":DiffviewClose<CR>";
      }
      # neogit
      {
        mode = "n";
        key = "<leader>gs";
        action = "function() require('neogit').open {} end";
        lua = true;
        desc = "Open neogit";
      }
      # toggleterm
      {
        mode = "n";
        key = "<D-t>";
        action = ":ToggleTerm<CR>";
        desc = "Toggle Terminal";
      }
      # markview
      {
        mode = "n";
        key = "<leader>mp";
        action = ":Markview toggle<CR>";
        desc = "Toggle Markdown Preview";
      }
      # gitsigns
      {
        mode = "n";
        key = "<leader>td";
        action = "function() require('gitsigns').toggle_deleted {} end";
        lua = true;
        desc = "Git toggle deleted";
      }
      {
        mode = "n";
        key = "<leader>hD";
        action = "function() require('gitsigns').diffthis '~' end";
        lua = true;
        desc = "Git diff buffer";
      }
      {
        mode = "n";
        key = "<leader>hs";
        action = "function() require('gitsigns').stage_hunk() end";
        lua = true;
        desc = "Stage Hunk";
      }
      {
        mode = "n";
        key = "<leader>hr";
        action = ''function() require('gitsigns').reset_hunk { vim.fn.line ".", vim.fn.line "v" } end'';
        lua = true;
        desc = "reset hunk";
      }
      {
        mode = "n";
        key = "<leader>hS";
        action = "function() require('gitsigns').stage_buffer {} end";
        lua = true;
        desc = "stage buffer";
      }
      {
        mode = "n";
        key = "<leader>hd";
        action = "function() require('gitsigns').diffthis {} end";
        lua = true;
        desc = "Git diff buffer";
      }
      {
        mode = "n";
        key = "<leader>tb";
        action = "function() require('gitsigns').toggle_current_line_blame {} end";
        lua = true;
        desc = "Git toggle blame line";
      }
      {
        mode = "n";
        key = "<leader>hb";
        action = "function() require('gitsigns').blame_line { full = true } end";
        lua = true;
        desc = "Git blame full line";
      }
      {
        mode = "n";
        key = "<leader>hP";
        action = "function() require('gitsigns').preview_hunk {} end";
        lua = true;
        desc = "Preview Hunk";
      }
      {
        mode = "n";
        key = "<leader>hR";
        action = "function() require('gitsigns').reset_buffer {} end";
        lua = true;
        desc = "Reset Buffer";
      }
      {
        mode = "n";
        key = "<leader>hu";
        action = "function() require('gitsigns').undo_stage_hunk {} end";
        lua = true;
        desc = "undo stage hunk";
      }
      {
        mode = "n";
        key = "<leader>hn";
        action = "function() require('gitsigns').next_hunk {} end";
        lua = true;
        desc = "next_hunk";
      }
      {
        mode = "n";
        key = "<leader>hp";
        action = "function() require('gitsigns').prev_hunk {} end";
        lua = true;
        desc = "prev_hunk";
      }
      # haskell-tools
      {
        mode = "n";
        key = "<leader>hs";
        action = "function() require('haskell-tools').hoogle.hoogle_signature() end";
        lua = true;
        desc = "Hoogle Signature";
      }
      {
        mode = "n";
        key = "<leader>ea";
        action = "function() require('haskell-tools').lsp.buf_eval_all() end";
        lua = true;
        desc = "Haskell Evaluate code lens";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = "function() require('haskell-tools').repl.toggle() end";
        lua = true;
        desc = "Haskell Toggle repl";
      }
      {
        mode = "n";
        key = "<leader>rf";
        action = "function() require('haskell-tools').repl.toggle(vim.api.nvim_buf_get_name(0)) end";
        lua = true;
        desc = "Haskell Toggle repl";
      }
      {
        mode = "n";
        key = "<leader>rq";
        action = "function() require('haskell-tools').repl.quit() end";
        lua = true;
        desc = "Haskell Toggle repl";
      }
      # LuaSnip
      {
        mode = ["i" "s"];
        key = "<C-j>";
        action = "function() require('luasnip').jump(1) end";
        lua = true;
      }
      {
        mode = ["i" "s"];
        key = "<C-l>";
        action = "function() require('luasnip').jump(-1) end";
        lua = true;
      }
      {
        mode = ["i" "s"];
        key = "<C-e>";
        action = ''
          function()
            local ls = require "luasnip"
            if ls.choice_active() then
              ls.change_choice(1)
            end
          end
        '';
        lua = true;
      }
    ];

    # toggleterm spec's terminal-mode keymaps (TermOpen autocmd, verbatim)
    augroups = [{name = "user_toggleterm_keymaps";}];
    autocmds = [
      {
        event = ["TermOpen"];
        pattern = ["term://*"];
        group = "user_toggleterm_keymaps";
        callback = mkLuaInline ''
          function()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
          end
        '';
      }
    ];
  };
}
