return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "rrethy/nvim-treesitter-endwise",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
