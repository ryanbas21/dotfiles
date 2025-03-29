local M = {}

local telescope_defaults = {
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  prompt_prefix = "   ",
  selection_caret = " ",
  entry_prefix = " ",
  vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--trim", -- add this value
  },
  -- buffer_previewer_maker = bad_files,
  sorting_strategy = "ascending",
  layout_config = {
    horizontal = {
      preview_cutoff = 0,
    },
  },
  mappings = {
    n = { ["q"] = require("telescope.actions").close },
    i = {
      ["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
      ["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
      ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist, -- send selected to quickfixlist
    },
  },
}

M.telescope = {
  defaults = telescope_defaults,
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    find_files = {
      find_command = {
        "fd", -- Using fd for searching
        "--max-depth",
        "8",
        "--hidden",
        "--follow",
        "--type",
        "f",
        "--strip-cwd-prefix",
      },
    },
  },
  extensions_list = {
    "fzf",
    "package_info",
    "import",
    "ui-select",
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", --
    },
    import = {},
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
    project = {},
    egrepify = {
      prefixes = {
        -- matches all lines that do not comprise sorter
        -- rg --invert-match -- sorter
        ["!"] = {
          flag = "invert-match",
        },
      },
    },
    package_info = {
      theme = "ivy",
    },
  },
}

return M
