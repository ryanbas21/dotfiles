-- require('nightfox').set()
-- require "github-theme".setup({
--   themeStyle = "dimmed",
--   functionStyle = "italic",
--   sidebars = {"qf", "vista_kind", "terminal", "packer"},
--   hideInactiveStatusline = true,
--   darkSidebar = false,
--   darkFloat = true,

--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   colors = { hint = "orange", error = "#ff0000" }
-- })
local catppuccino = require("catppuccino")

-- configure it
catppuccino.setup(
    {
		colorscheme = "catppuccino",
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
			nvimtree = false,
			which_key = false,
			indent_blankline = true,
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


