local telescope = require("telescope")
local actions = require "telescope.actions"
local layout_actions = require "telescope.actions.layout"
local trouble = require("trouble.providers.telescope")
local files = require "telescope_config.find_files"
local buffers = require "telescope_config.buffers"
local git = require "telescope_config.git"

local function keymaps()
    vim.keymap.set("n", "<leader>r", "<cmd>Telescope resume<CR>", { noremap = true })
    vim.keymap.set("n", "<leader><leader>", files.git_files, { noremap = true })
    vim.keymap.set("n", "<leader>f", files.find, { noremap = true })
    vim.keymap.set("n", "<leader>b", files.buffers, { noremap = true })
    vim.keymap.set("n", "<Leader>;", buffers.buffer_fuzzy_find, { noremap = true })
    vim.keymap.set("n", "<leader>bc", git.buffer_commits, { noremap = true })
    vim.keymap.set("n", "<leader>bg", git.commit, { noremap = true })
    vim.keymap.set("n", "<leader>S", buffers.grep_cursor, { noremap = true })
    vim.keymap.set("n", "<leader>s", buffers.search_string, { noremap = true })
end

  local is_win = vim.fn.has "win32" == 1
  if not is_win then
      require("telescope").load_extension "fzf"
  end

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
              n = { ["<c-t>"] = trouble.open_with_trouble },
              i = {
                   ["<c-t>"] = trouble.open_with_trouble,
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
      },
  }

keymaps();
