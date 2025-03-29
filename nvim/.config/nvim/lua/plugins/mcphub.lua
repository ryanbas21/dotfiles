return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "bundled_build.lua",
  config = function()
    require("mcphub").setup {
      auto_approve = true,
      --- `mcp-hub` binary related options-------------------
      config = vim.fn.expand "~/.config/mcphub/servers.json", -- Absolute path to MCP Servers config file (will create if not exists)
      use_bundled_binary = true, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
      port = 37373, -- The port `mcp-hub` server listens to
      shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
      mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
    }
  end,
}
