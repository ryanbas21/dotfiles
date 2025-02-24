return {
  "lewis6991/hover.nvim",
  config = function()
    require("hover").setup {
      init = function()
        -- Require providers
        require "hover.providers.lsp"
        require "hover.providers.gh"
        require "hover.providers.gh_user"
        require "hover.providers.jira"
        require "hover.providers.dap"
        require "hover.providers.fold_preview"
        require "hover.providers.diagnostic"
        require "hover.providers.man"
        require "hover.providers.dictionary"
      end,
      preview_opts = {
        border = "single",
      },
      -- Whether the contents of a currently open hover window should be moved
      -- to a :h preview-window when pressing the hover keymap.
      preview_window = true,
      title = true,
      mouse_providers = {
        "LSP",
      },
      mouse_delay = 1000,
    }
  end,
  keys = {
    {
      "K",
      function()
        require("hover").hover()
      end,
      { desc = "hover.nvim" },
    },
    {
      "gK",
      function(a)
        require("hover").hover_select(a)
      end,
      { desc = "hover.nvim" },
    },
    {
      "<C-t>",
      function(a)
        require("hover").hover_switch "previous"
      end,
      { desc = "hover previous provider" },
    },
    {
      "<C-y>",
      function(a)
        require("hover").hover_switch "next"
      end,
      { desc = "hover next provider" },
    },
    {
      "<MouseMove>",
      function()
        require("hover").hover_mouse {}
      end,
      { desc = "hover mouse move" },
    },
  },
}
-- vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })

-- vim.o.mousemoveevent = true
