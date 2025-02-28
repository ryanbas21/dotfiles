--
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@class NvChadConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  transparency = false,
}

M.lsp = {
  signature = true,
}

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = false,
    },
  },
}

M.copilot = {
  suggestion = {
    enable = false,
  },
  panel = {
    enable = false,
  },
}

M.term = {}

return M
