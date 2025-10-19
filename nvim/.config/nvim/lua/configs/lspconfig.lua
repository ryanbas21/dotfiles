local blink_cmp = require "blink.cmp"
local lspconfig = require "lspconfig"

local lspservers = require("configs.lsp.lsp_servers").servers
local on_attach = require("configs.lsp.handlers").on_attach

local capabilities = blink_cmp.get_lsp_capabilities()

local configs_lib = require "lspconfig.configs"

for lsp, config in pairs(lspservers) do
  local setup_config = {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  for k, v in pairs(config) do
    setup_config[k] = v
  end

  if lspconfig[lsp] then
    lspconfig[lsp].setup(setup_config)
  else
    print("LSP server '" .. lsp .. "' not found in lspconfig. Skipping setup.")
  end
end
