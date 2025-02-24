return {
  "akinsho/org-bullets.nvim",
  ft = { "org" },
  opts = {
    concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
    symbols = {
      -- list symbol
      list = "•",
      -- headlines can be a list
      headlines = { "◉", "○", "✸", "✿" },
      -- or a function that receives the defaults and returns a list
      -- or false to disable the symbol. Works for all symbols
      -- or a table of tables that provide a name
      -- and (optional) highlight group for each headline level
    },
    checkboxes = {
      half = { "", "@org.checkbox.halfchecked" },
      done = { "✓", "@org.keyword.done" },
      todo = { "˟", "@org.keyword.todo" },
    },
  },
}
