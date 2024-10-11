local ok, packageinfo = pcall(require, "package-info")

if not ok then
  return
end

packageinfo.setup {
  autostart = true,
  package_manager = "pnpm",
}

-- Show dependency versions
vim.keymap.set(
  "n",
  "<LEADER>ps",
  packageinfo.show,
  { silent = true, noremap = true, desc = "show dependency versions" }
)

-- Hide dependency versions
vim.keymap.set(
  "n",
  "<LEADER>ph",
  packageinfo.hide,
  { silent = true, noremap = true, desc = "hide dependency versions" }
)

-- Toggle dependency versions
vim.keymap.set(
  "n",
  "<LEADER>pt",
  packageinfo.toggle,
  { silent = true, noremap = true, desc = "toggle dependency versions" }
)

-- Update dependency on the line
vim.keymap.set(
  "n",
  "<LEADER>pu",
  packageinfo.update,
  { silent = true, noremap = true, desc = "update dependency on line" }
)

-- Delete dependency on the line
vim.keymap.set(
  "n",
  "<LEADER>pd",
  packageinfo.delete,
  { silent = true, noremap = true, desc = "delete dependency on line" }
)

-- Install a new dependency
vim.keymap.set(
  "n",
  "<LEADER>pi",
  packageinfo.install,
  { silent = true, noremap = true, desc = "install a new dependency" }
)

-- Install a different dependency version
vim.keymap.set(
  "n",
  "<LEADER>pp",
  packageinfo.change_version,
  { silent = true, noremap = true, desc = "install a different dependency version" }
)
