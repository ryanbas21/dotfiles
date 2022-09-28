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
