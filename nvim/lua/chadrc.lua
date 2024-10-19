--
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@class NvChadConfig
local M = {}

M.base46 = {
  theme = "ayu_dark",
  transparency = false,
}

M.lsp = {
  signature = true,
}

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = false,
    },
  },
}

return M
