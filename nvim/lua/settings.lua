 require 'telescope_config'
 require '_devicons'
 require '_compe'
 require '_devicons'
 require '_diffview'
 require '_treesitter'
 require 'neoscroll'.setup()
 require 'gitsigns'.setup()
 require 'lsp'
 require 'lspsaga'.init_lsp_saga()
 require 'compe'
 require 'lsp'
 require 'nvim-autopairs'.setup({ map_cr = true, map_complete = true })
 require'bufferline'.setup{}

 vim.g.dashboard_custom_section = {
        a = {description = {"  Find File                 SPC f"}, command = "Telescope find_files"},
        b = {description = {"   Git Files                 SPC SPC"}, command = "Telescope git_files"},
        c = {description = {"  Recents                   Ctrl P"}, command = "Telescope frecency"},
        d = {description = {"  Find Word                 SPC s"}, command = "Telescope live_grep"},
        e = {description = {"  Find In Buffer            SPC ;"}, command = "Telescope current_buffer_fuzzy_find"}
    }


require "github-theme".setup({
  themeStyle = "dimmed",
  functionStyle = "italic",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
  hideInactiveStatusline = true,
  darkSidebar = false,
  darkFloat = true,

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = { hint = "orange", error = "#ff0000" }
})
