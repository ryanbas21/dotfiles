-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local servers = {
  eslint = {},
  angularls = {},
  bashls = {},
  biome = {},
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
  lua_ls = {},
  marksman = {},
  prismals = {},
  purescriptls = {},
  rescriptls = {},
  tailwindcss = {},
  svelte = {},
  ts_ls = {},
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
