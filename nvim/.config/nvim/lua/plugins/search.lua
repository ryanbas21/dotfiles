return {
  "FabianWirth/search.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    append_tabs = { -- append_tabs will add the provided tabs to the default ones
      {
        "Buffer Commits", -- or name = "Commits"
        function()
          require("telescope.builtin").git_bcommits {
            max_results = 30,
          }
        end,
        available = function() -- optional
          return vim.fn.isdirectory ".git" == 1
        end,
      },
      {
        "Git Commits", -- or name = "Commits"
        function()
          require("telescope.builtin").git_commits {
            max_results = 30,
          }
        end,
        available = function() -- optional
          return vim.fn.isdirectory ".git" == 1
        end,
      },
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("search").open { tab_id = 1 }
      end,
      desc = "search all files",
      noremap = true,
    },
    {
      "<leader><leader>",
      function()
        require("search").open { tab_id = 2 }
      end,
      desc = "telescope search git files",
    },
    {
      "<leader>fs",
      function()
        require("search").open { tab_id = 3 }
      end,
      desc = "telescope search repo",
    },
    {
      "<leader>bgc",
      function()
        require("search").open { tab_id = 4 }
      end,
      desc = "Buffer git commits",
    },
  },
}
