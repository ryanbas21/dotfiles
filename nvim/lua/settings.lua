require 'treesitter'
require'bufferline'.setup{
   diagnostics = "nvim_lsp"
  }
require 'telescope_config'
-- require '_compe'
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

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<v>",                        cb = tree_cb("vsplit") },
      { key = "<x>",                        cb = tree_cb("split") },
      { key = "<t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "]c",                           cb = tree_cb("next_git_item") },
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "s",                            cb = tree_cb("vsplit") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
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
