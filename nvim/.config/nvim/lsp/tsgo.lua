--- Resolve the tsgo binary by walking up from the buffer's directory.
--- In monorepos, the binary is often hoisted to the workspace root, so we
--- check each ancestor's node_modules/.bin/tsgo until we find one.
---@return string
local function resolve_tsgo()
  local buf_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")

  for dir in vim.fs.parents(buf_dir) do
    local candidate = dir .. "/node_modules/.bin/tsgo"
    if vim.uv.fs_stat(candidate) then
      return candidate
    end
  end

  return "tsgo"
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers)
    return vim.lsp.rpc.start(resolve_tsgo(), { "--lsp", "--stdio" }, dispatchers)
  end,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        -- Disable dynamic registration to avoid tsgo sending "bundled:///" glob
        -- patterns that Neovim's glob parser cannot handle.
        dynamicRegistration = false,
      },
    },
  },
}
