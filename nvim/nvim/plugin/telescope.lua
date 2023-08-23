local telescope = require("telescope")
local actions = require "telescope.actions"
local layout_actions = require "telescope.actions.layout"

  telescope.setup {
      defaults = {
          vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
              "--hidden",
              "--glob=!.git/",
          },
          mappings = {
              i = {
                  ["<C-w>"] = function()
                      vim.api.nvim_input "<c-s-w>"
                  end,
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous,
                  ["<C-p>"] = actions.cycle_history_prev,
                  ["<C-n>"] = actions.cycle_history_next,
                  ["<C-l>"] = layout_actions.toggle_preview,
                  ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                  ["<Esc>"] = actions.close,
                  ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                  ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
              },
          },
      },
      extensions = {
          project = {
              hidden_files = false,
          },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          -- even more opts
        },

      },
    ["fzf"] = require("telescope.themes").get_dropdown({})
  }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension "fzf"
require("telescope").load_extension("refactoring")


