local ok, notify = pcall(require, "notify")
if not ok then
	return
end
vim.notify = notify

require("telescope").load_extension("notify")

vim.keymap.set("n", "<leader>fn", require("telescope").extensions.notify.notify)
vim.keymap.set("n", "<Leader>nd", notify.dismiss, {})
