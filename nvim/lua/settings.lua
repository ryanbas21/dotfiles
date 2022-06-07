require 'colors'
require 'completion'
require 'neotest'
require 'telescope_config'.setup()
require 'nvim-treesitter'
require 'neoscroll'.setup()
require 'filetree'
require 'git'
require 'statusbar'
require 'nvim-autopairs'.setup({ map_cr = true, map_complete = true })


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
