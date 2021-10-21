require 'treesitter'
require 'colors'
require '_dashboard'
require 'nvimtree'
require 'bufferline'.setup{
   diagnostics = "nvim_lsp"
  }
require 'telescope_config'
require '_devicons'
require '_diffview'
require '_galaxy_line'
require '_neogit'
require 'lsp'
require '_compe'
require 'neoscroll'.setup()
require 'gitsigns'.setup()
require 'lspsaga'.init_lsp_saga()
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
