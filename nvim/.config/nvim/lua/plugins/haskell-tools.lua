return {
  "mrcjkb/haskell-tools.nvim",
  version = "^4", -- Recommended
  ft = { "hs", "haskell" },
  init = function()
    local blink_cmp = require "blink.cmp"
    local on_attach = require("configs.lsp.handlers").on_attach
    vim.g.haskell_tools = {
      hls = {
        capabilities = blink_cmp.get_lsp_capabilities(),
        default_settings = {
          haskell = {
            formattingProvider = "ormolu",
            plugins = {
              stan = { globalOn = false },
            },
          },
        },
      },
    }
  end,
  keys = {
    {
      "<leader>hs",
      function()
        require("haskell-tools").hoogle.hoogle_signature()
      end,
      desc = "Hoogle Signature",
    },
    {
      "<leader>ea",
      function()
        require("haskell-tools").lsp.buf_eval_all()
      end,
      desc = "Haskell Evaluate code lens",
    },
    {
      "<leader>rr",
      function()
        require("haskell-tools").repl.toggle()
      end,
      desc = "Haskell Toggle repl",
    },
    {
      "<leader>rf",
      function()
        require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0))
      end,
      desc = "Haskell Toggle repl",
    },
    {
      "<leader>rq",
      function()
        require("haskell-tools").repl.quit()
      end,
      desc = "Haskell Toggle repl",
    },
  },
}
