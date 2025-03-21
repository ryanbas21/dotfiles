local M = {}

M.servers = {
  -- Language servers with default settings
  eslint = {},
  -- denols = {},

  angularls = {},
  bashls = {},
  clojure_lsp = {},
  -- htmx = {},
  ocamllsp = {
    env = { "$HOME/.opam/default/bin/ocamllsp" },
  },
  cssls = {},
  css_variables = {},
  cssmodules_ls = {},
  diagnosticls = {},
  html = {},
  jdtls = {},
  marksman = {},
  prismals = {},
  purescriptls = {},
  rescriptls = {},
  -- hls = {
  --   haskell = {
  --
  --     formattingProvider = "ormolu",
  --     hlintOn = true,
  --     plugin = {
  --       stan = { globalOn = false },
  --     },
  --   },
  -- },
  tailwindcss = {},
  svelte = {},
  gleam = {},
  biome = {},
  zls = {},
  grammarly = {},
  dockerls = {},
  -- ts_ls = {},
  -- --
  -- Language servers with custom settings
  elixirls = {
    cmd = { "$HOME/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
  },
  elmls = {
    init_options = {
      -- elmReviewDiagnostics = "error",
      elmAnalyseTrigger = "save",
      onlyUpdateDiagnosticsOnSave = true,
    },
    handlers = {
      -- See https://github.com/elm-tooling/elm-language-server/discussions/961
      -- See https://github.com/joakin/nvim/blob/be72c11ff2d2c3ee6d6350f2221aabcca373adae/lua/plugins/lspconfig.lua#L148-L157
      ["window/showMessageRequest"] = function(whatever, result)
        -- For some reason, the showMessageRequest handler doesn't work with
        -- the format failed error. It just hangs on the screen and can't
        -- interact with the vim.ui.select thingy. So skip it.
        if result.message:find("Running elm-format failed", 1, true) then
          print(result.message)
          return vim.NIL
        end
        return vim.lsp.handlers["window/showMessageRequest"](whatever, result, {})
      end,
    },
  },

  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "require" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data
        telemetry = {
          enable = false,
        },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- Disable built-in schemaStore support for this plugin
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

return M
