local ok, inlayhints = pcall(require, "lsp-inlayhints")
local function supports_inlay_hints(bufnr)
    local clients = vim.lsp.get_active_clients { bufnr = bufnr }
    for _, client in ipairs(clients) do
        if client.server_capabilities.inlayHintProvider then
            return true
        end
    end
    return false
end

  vim.api.nvim_create_augroup("LspAttach_inlayhints", {})

  vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if ok then 
      inlayhints.on_attach(client, bufnr)
    end
  end,
})
