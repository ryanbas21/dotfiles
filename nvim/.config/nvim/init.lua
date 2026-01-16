vim.g.mapleader = " "

-- Add Mason binaries to PATH before plugins load (needed for LSP servers)
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  { import = "plugins" },
}, require "configs.lazy")

-- Deferred loads
vim.schedule(function()
  require "mappings"
  require "options"
  require "autocmds"
end)
