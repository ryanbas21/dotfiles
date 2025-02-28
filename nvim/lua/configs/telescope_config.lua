local whaler_config = require("configs.whaler_config").Whaler
local bad_files = require("configs.telescope_functions").bad_files

local M = {}

local telescope_defaults = {
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
  buffer_previewer_maker = bad_files,
  sorting_strategy = "ascending",
  layout_config = {
    horizontal = {
      prompt_position = "top",
      preview_width = 0.55,
    },
    width = 0.87,
    height = 0.80,
  },
  mappings = {
    n = { ["q"] = require("telescope.actions").close },
  },
}

M.telescope = {
  defaults = telescope_defaults,
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
  },
  extensions_list = {
    "themes",
    "terms",
    "fzf",
    "whaler",
    "package_info",
    "orgmode",
    "import",
    "telescope-tabs",
    "egrepify",
    "project",
  },
  extensions = {
    project = {},
    egrepify = {
      prefixes = {
        -- matches all lines that do not comprise sorter
        -- rg --invert-match -- sorter
        ["!"] = {
          flag = "invert-match",
        },
        -- HOW TO OPT OUT OF PREFIX
        -- ^ is not a default prefix and safe example
        -- ["^"] = false,
      },
      mappings = {
        i = {
          -- toggle prefixes, prefixes is default
          ["<C-z>"] = require("telescope._extensions.egrepify.actions").toggle_prefixes,
          -- toggle AND, AND is default, AND matches tokens and any chars in between
          ["<C-a>"] = require("telescope._extensions.egrepify.actions").toggle_and,
          -- toggle permutations, permutations of tokens is opt-in
          ["<C-r>"] = require("telescope._extensions.egrepify.actions").toggle_permutations,
        },
      },
    },
    whaler = whaler_config,
    package_info = {
      theme = "ivy",
    },
  },
}

return M
