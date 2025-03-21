return {
  "fdschmidt93/telescope-egrepify.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>;",
      function()
        require("telescope").extensions.egrepify.egrepify {}
      end,
      desc = "Live grep repo",
    },
  },
}
