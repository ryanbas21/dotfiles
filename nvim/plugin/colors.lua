-- require('tokyonight').set()
-- require "github-theme".setup()
local catppuccino = require("catppuccin")

-- configure it
catppuccino.setup()

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

-- vim.cmd([[colorscheme tokyonight-storm]])
vim.cmd[[colorscheme catppuccin]]
