-- lua/configs/lsp/init.lua
local blink_cmp = require "blink.cmp"
local servers = require("configs.lsp.lsp_servers").servers
local on_attach = require("configs.lsp.handlers").on_attach
local capabilities = blink_cmp.get_lsp_capabilities()

-- Set up LspAttach autocmd to handle on_attach for all servers
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if client then
      on_attach(client, bufnr)
    end
  end,
})

for server_name, value in pairs(servers) do
  -- merge your defaults with each server's table
  local cfg = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
  }, value or {})

  -- Configure the server with settings first
  vim.lsp.config(server_name, cfg)

  -- Then enable it
  vim.lsp.enable(server_name)
end
