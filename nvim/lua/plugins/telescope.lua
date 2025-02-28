local telescope_config = require("configs.telescope_config").telescope
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "LukasPietzschmann/telescope-tabs",
      keys = {
        {
          "<leader>gT",
          function()
            require("telescope-tabs").list_tabs {}
          end,
          { desc = "List tabs" },
        },
      },
    },
    {
      "piersolenski/telescope-import.nvim",
      dependencies = "nvim-telescope/telescope.nvim",
      keys = {

        {
          "<LEADER>ti",
          ":Telescope import<CR>",
          { desc = "Telescope import" },
        },
      },
    },
    {
      "joaomsa/telescope-orgmode.nvim",
      dependencies = {
        "nvim-orgmode/orgmode",
      },
      keys = {
        {
          "<LEADER>r",
          function()
            require("telescope").extensions.orgmode.refile_heading {}
          end,
        },
        {
          "<LEADER>fh",
          function()
            require("telescope").extensions.orgmode.search_headings {}
          end,
        },
        {
          "<LEADER>li",
          function()
            require("telescope").extensions.orgmode.insert_link {}
          end,
        },
      },
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    "SalOrak/whaler",
  },
  opts = telescope_config,
  keys = {
    {
      "<leader>;",
      function()
        require("telescope").extensions.egrepify.egrepify {}
      end,
      { desc = "Live grep repo" },
    },
    {
      "<leader>ww",
      function()
        require("telescope").extensions.whaler.whaler {}
      end,
      { desc = "Whaler change dir", noremap = true },
    },
    {
      "<C-p>",
      function()
        require("telescope").extensions.project.project {}
      end,
      { desc = "Telescope project", noremap = true, silent = true },
    },
  },
}
