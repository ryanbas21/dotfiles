local leet_arg = "leetcode.nvim"
return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Leet",
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  opts = {
    arg = leet_arg,
    lang = "python3",
    -- configuration goes here
  },
}
