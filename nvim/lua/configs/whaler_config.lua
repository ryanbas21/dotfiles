local M = {}

local directories = {
  "/Users/ryan.basmajian/.config/nvim",
  { path = "/Users/ryan.basmajian/programming", alias = "programming" },
  { path = "/Users/ryan.basmajian/programming/ping-javascript-sdk/", alias = "js-sdk" },
  { path = "/Users/ryan.basmajian/programming/ping-javascript-sdk/packages", alias = "sdkpackages" },
}

M.Whaler = {
  file_explorer = "telescope_file_browser",
  -- Whaler configuration
  directories = directories,
  -- You may also add directories that will not be searched for subdirectories
  oneoff_directories = {
    { path = "/Users/ryan.basmajian/.config/nvim/", alias = "df" },
  },
}

return M
