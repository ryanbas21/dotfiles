---@type vim.lsp.Config
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  settings = {
    yaml = {
      schemastore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
