return {
  "chipsenkbeil/distant.nvim",
  branch = "v0.3",
  cmd = { "DistantInstall", "Distant" },
  config = function()
    require("distant"):setup()
  end,
}
