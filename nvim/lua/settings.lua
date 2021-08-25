require 'treesitter'
require'nvimtree'
require'bufferline'.setup{
   diagnostics = "nvim_lsp"
  }
require 'telescope_config'
require '_devicons'
require '_diffview'
require'_galaxy_line'
require '_neogit'
require 'lsp'
require 'neoscroll'.setup()
require 'gitsigns'.setup()
require 'lspsaga'.init_lsp_saga()
require 'nvim-autopairs'.setup({ map_cr = true, map_complete = true })

 vim.g.dashboard_custom_section = {
        a = {description = {"  Find File                 SPC f"}, command = "Telescope find_files"},
        b = {description = {"   Git Files                 SPC SPC"}, command = "Telescope git_files"},
        c = {description = {"  Recents                   Ctrl P"}, command = "Telescope frecency"},
        d = {description = {"  Find Word                 SPC s"}, command = "Telescope live_grep"},
        e = {description = {"  Find In Buffer            SPC ;"}, command = "Telescope current_buffer_fuzzy_find"}
    }

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


-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   vim.g["loaded_" .. plugin] = 1
end
