local ok, lspkind = pcall(require, "lspkind")

if not ok then
	return
end

lspkind.init({
  mode = "symbol_text",
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
