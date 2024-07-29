local ok, clearaction = pcall(require, "clear-action")
if not ok then
  return
end

clearaction.setup {
  mappings = {
    -- The values can either be a string or a string tuple (with description)
    -- example: "<leader>aq" | { "<leader>aq", "Quickfix" }
    -- Or if you want more control: { key = "<leader>aq", mode = { "n" }, options = { desc = "Quickfix" } }
    -- `options` accetps the same keys as vim.keymap.set()
    code_action = "<Leader>ca", -- a modified version of `vim.lsp.buf.code_action`
    apply_first = "<Leader>af", -- directly applies the first code action
    -- These are just basically `vim.lsp.buf.code_action` with the `apply` option with some filters
    -- If there's only one code action, it gets automatically applied.
    quickfix = "<Leader>qf", -- can be filtered with the `quickfix_filter` option bellow
    quickfix_next = nil, -- tries to fix the next diagnostic
    quickfix_prev = nil, -- tries to fix the previous diagnostic
    refactor = "<Leader>rf",
    refactor_inline = nil,
    refactor_extract = nil,
    refactor_rewrite = nil,
    source = nil,
    -- server-specific mappings, server_name = {...}
    -- This is a map of code actions prefixes and keys
    actions = {
      -- example:
      -- ["rust_analyzer"] = {
      --   ["Inline"] = "<leader>ai"
      --   ["Add braces"] = { "<leader>ab", "Add braces" }
      -- }
    },
  },
}
