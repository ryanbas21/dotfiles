return {
  "nvim-orgmode/telescope-orgmode.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-orgmode/orgmode",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension "orgmode"
  end,
  keys = {
    {
      "n",
      "<leader>r",
      function()
        require("telescope").extensions.orgmode.refile_heading {}
      end,
    },
    {
      "n",
      "<leader>fh",
      function()
        require("telescope").extensions.orgmode.search_headings {}
      end,
    },
    {
      "n",
      "<leader>li",
      function()
        require("telescope").extensions.orgmode.insert_link {}
      end,
    },
  },
}
