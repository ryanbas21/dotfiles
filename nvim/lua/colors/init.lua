-- require('nightfox').set()
require "github-theme".setup()
local catppuccino = require("catppuccin")

-- configure it
catppuccino.setup(
    {
		transparency = false,
		styles = {
			comments = "italic",
			functions = "italic",
			keywords = "italic",
			strings = "NONE",
			variables = "NONE",
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				styles = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic"
				}
			},
			lsp_trouble = true,
			lsp_saga = true,
			gitgutter = false,
			gitsigns = true,
			telescope = true,
			nvimtree = {
			  enabled = true,
			  show_root = true
			},
			which_key = false,
			indent_blankline = {
			  enabled = true,
			  colored_indent_levels = true
			},
			dashboard = true,
			neogit = true,
			vim_sneak = false,
			fern = false,
			barbar = false,
			bufferline = true,
			markdown = true,
		}
	}
)

-- load it
catppuccino.load()

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.cmd[[colorscheme catppuccin]]

