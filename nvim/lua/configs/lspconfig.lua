-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local servers = {
  eslint = {},
  angularls = {},
  bashls = {},
  elmls = {
    init_options = {
      --elmReviewDiagnostics = "error",
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
        return vim.lsp.handlers["window/showMessageRequest"](whatever, result)
      end,
    },
  },
  -- biome = {},
  clojure_lsp = {},
  cssls = {},
  css_variables = {},
  cssmodules_ls = {},
  diagnosticls = {},
  docker_compose_language_service = {},
  dockerls = {},
  html = {},
  jdtls = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  marksman = {},
  prismals = {},
  purescriptls = {},
  rescriptls = {},
  tailwindcss = {},
  svelte = {},
  -- ts_ls = {},
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

-- lsps with default config
for lsp in pairs(servers) do
  if lsp == "lua_ls" then
    lspconfig["lua_ls"].setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {
              "vim",
              "require",
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = function(client, bufnr)
        -- if lsp == "ts_ls" then
        --   require("twoslash-queries").attach(client, bufnr)
        -- end

        return on_attach(client, bufnr)
      end,
      on_init = on_init,
      capabilities = capabilities,
    }
  else
    lspconfig[lsp].setup {
      on_attach = function(client, bufnr)
        if lsp == "ts_ls" then
          require("twoslash-queries").attach(client, bufnr)
        end
        return on_attach(client, bufnr)
      end,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
end
