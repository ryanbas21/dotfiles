return {
  "ndmitchell/ghcid",
  cmd = "Ghcid",
  ft = { "haskell" },
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "/plugins/nvim")
  end,
}
