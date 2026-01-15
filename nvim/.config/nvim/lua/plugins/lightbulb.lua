return {
  "kosayoda/nvim-lightbulb",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    autocmd = { enabled = true },
    sign = { enabled = false },
    virtual_text = { enabled = true, text = "" },
  },
}
