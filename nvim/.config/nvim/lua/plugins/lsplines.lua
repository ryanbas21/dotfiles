return {
  enabled = false,
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  keys = {
    {
      "<leader>l",
      function()
        require("lsp_lines").toggle {}
      end,
      desc = "Toggle lsp_lines",
    },
  },
}
