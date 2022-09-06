-- Lua
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),          -- Stage all entries.
      ["U"]             = cb("unstage_all"),        -- Unstage all entries.
      ["R"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    }
  }
}

-- require'neogit'.setup {
--   disable_signs = false,
--   disable_context_highlighting = false,
--   disable_commit_confirmation = false,
--   -- customize displayed signs
--   signs = {
--     -- { CLOSED, OPENED }
--     section = { ">", "v" },
--     item = { ">", "v" },
--     hunk = { "", "" },
--   },
--   integrations = {
--     -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
--     -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
--     diffview = true
--   },
--   -- override/add mappings
--   mappings = {
--     -- modify status buffer mappings
--     status = {
--       -- Adds a mapping with "B" as key that does the "BranchPopup" command
--       ["B"] = "BranchPopup",
--     }
--   }
-- }
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup {
    keymaps = {},
    current_line_blame = true,
    current_line_blame_opts = {
        delay = vim.o.updatetime,
    },
}
local opt = { noremap = true }
vim.keymap.set("n", "]c", gitsigns.next_hunk, opt)
vim.keymap.set("n", "[c", gitsigns.prev_hunk, opt)

vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, opt)
vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, opt)
vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, opt)
vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, opt)

vim.keymap.set("o", "ah", gitsigns.select_hunk, opt)
vim.keymap.set("v", "ah", gitsigns.select_hunk, opt)
