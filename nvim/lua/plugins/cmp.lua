local overrides = require "chadrc"

return {
  "hrsh7th/nvim-cmp",
  opts = {
    sources = {
      { name = "nvim_lsp", group_index = 1 },
      { name = "copilot", group_index = 1 },
      { name = "npm", keyword_length = 1 },
      { name = "luasnip", group_index = 1 },
      { name = "buffer", group_index = 2 },
      { name = "nvim_lua", group_index = 2 },
      { name = "path", group_index = 2 },
      { name = "dotenv", group_index = 2 },
      { name = "git", group_index = 2 },
      { name = "mdlink", group_index = 2 },
      { name = "orgmode", group_index = 2 },
      { name = "org_roam", group_index = 2 },
    },
  },
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      opts = overrides.copilot,
    },
    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter",
    },
    { "sudo-burger/cmp-org-roam", dependencies = { "chipsenkbeil/org-roam.nvim" } },
    {
      "David-Kunz/cmp-npm",
      dependencies = { "nvim-lua/plenary.nvim" },
      ft = "json",
      config = function()
        require("cmp-npm").setup {}
      end,
    },
    { "SergioRibera/cmp-dotenv" },
  },
}
