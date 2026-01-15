return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    return {
      sources = {
        require("null_ls").builtins.code_actions.refactoring,
        require("null_ls").builtins.formatting.stylua,
        require("null_ls").builtins.completion.spell,
        require "none-ls.code_actions.eslint",
        require "none-ls.diagnostics.eslint", -- requires none-ls-extras.nvim
      },
    }
  end,
}
