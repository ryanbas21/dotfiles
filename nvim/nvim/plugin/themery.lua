local ok, themery = pcall(require, 'themery');

if not ok then
  return
end

themery.setup({
  themes = {"catppuccin", "catppuccin-frappe", "catppuccin-mocha", "catppuccin-macchiato", "oxocarbon", "nordic", "nightfox", "nightcity", "onedark_dark", "onedark"  }, -- Your list of installed colorschemes
  themeConfigFile = "~/.config/nvim/lua/settings/theme.lua", -- Described below
  livePreview = true, -- Apply theme while browsing. Default to true.
})
