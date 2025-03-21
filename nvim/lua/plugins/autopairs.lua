return {
  "altermo/ultimate-autopair.nvim",
  branch = "v0.6", --recommended as each new version will have breaking changes
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rrethy/nvim-treesitter-endwise",
    {
      "kylechui/nvim-surround",
      version = "*", -- use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup {
          -- configuration here, or leave empty to use defaults
        }
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup {
          enable = true,
        }
      end,
    },
  },
  config = function()
    require("ultimate-autopair").setup {}
  end,
}
