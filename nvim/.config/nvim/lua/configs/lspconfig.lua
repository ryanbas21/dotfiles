local blink_cmp = require "blink.cmp"
local lspconfig = require "lspconfig"

local lspservers = require("configs.lsp.lsp_servers").servers
local on_attach = require("configs.lsp.handlers").on_attach
local special_handlers = require("configs.lsp.handlers").special_handlers

local capabilities = blink_cmp.get_lsp_capabilities()

local configs_lib = require "lspconfig.configs"

for lsp, config in pairs(lspservers) do
  local setup_config = {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  -- Add server-specific settings if they exist
  for k, v in pairs(config) do
    setup_config[k] = v
  end

  -- Handle special on_attach cases
  if special_handlers[lsp] then
    setup_config.on_attach = special_handlers[lsp]
  else
    setup_config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end
  end

  local has_config = configs_lib[lsp] ~= nil

  if has_config then
    lspconfig[lsp].setup(setup_config)
  end
end
