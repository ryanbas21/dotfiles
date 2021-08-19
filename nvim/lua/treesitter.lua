require'nvim-treesitter.configs'.setup {
  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'none',
    },
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          typescript = "(function_definition) @function",
          javascript = "(function_definition) @function",
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
      refactor = {
	highlight_definitions = { enable = true },
	navigation = {
	  enable = true,
	  keymaps = {
	    goto_definition = "gld"
	  },
	},
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "glr"
        },
      },
     swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  },
}
require("github-theme").setup({
  themeStyle = "dimmed",
  functionStyle = "italic",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
  hideInactiveStatusline = true,
  darkSidebar = false,
  darkFloat = true,

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = { hint = "orange", error = "#ff0000" }
})
