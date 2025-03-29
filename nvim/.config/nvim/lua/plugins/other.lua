return {
  "rgroli/other.nvim",
  config = function()
    require("other-nvim").setup {
      mappings = {

        { pattern = "(.*)%.(tsx?)$", target = "%1.test.%2", context = "test" },
        { pattern = "(.*)%.test.(tsx?)$", target = "%1.ts" },
        { pattern = "(.*)%.test-d.(tsx?)$", target = "%1.%2", context = "test" },
        -- Define how to navigate to the test files
      },
      style = {
        -- How the plugin paints its window borders
        -- Allowed values are none, single, double, rounded, solid and shadow
        border = "solid",

        -- Column separator for the window
        separator = "|",

        -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
        width = 0.7,

        -- min height in rows.
        -- when more columns are needed this value is extended automatically
        minHeight = 2,
      },
    }
  end,
  keys = {
    { "<leader>ll", "<cmd>Other<CR>", { desc = "Other" } },
    { "<leader>ltn", "<cmd>OtherTabNew<CR>", { desc = "Other in a new tab" } },
    { "<leader>lp", "<cmd>OtherSplit<CR>", { desc = "Other in a Split" } },
    { "<leader>lv", "<cmd>OtherVSplit<CR>", { desc = "Other in a Vertical Split" } },
    { "<leader>lc", "<cmd>OtherClear<CR>", { desc = "Other Clear" } },
    { "<leader>lt", "<cmd>Other test<CR>", { desc = "Other Test" } },
  },
}
