local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

nvlsp.defaults() -- loads nvchad's defaults

local servers = {
  "eslint",
  "angularls",
  "bashls",
  "basedpyright",
  "biome",
  "bzl",
  "clojure_lsp",
  "cmake",
  "crystalline",
  "cssls",
  "css_variables",
  "cssmodules_ls",
  "dhall_lsp_server",
  "diagnosticls",
  "docker_compose_language_service",
  "dockerls",
  "dprint",
  "dotls",
  "html",
  "jdtls",
  "jsonls",
  "lua_ls",
  "marksman",
  "prismals",
  "purescriptls",
  "rescriptls",
  "tailwindcss",
  "svelte",
  "ts_ls",
  "yamlls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lsp == "jsonls" then
    lspconfig["jsonls"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }
  end
  if lsp == "yamlls" then
    lspconfig["yamlls"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
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
    }
  end
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
