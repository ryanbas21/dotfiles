return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = "json",
  opt = {
    colors = {
      up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
      outdated = "#d19a66", -- Text color for outdated dependency virtual text
      invalid = "#ee4b2b", -- Text color for invalid dependency virtual text
    },
    icons = {
      enable = true, -- Whether to display icons
      style = {
        up_to_date = "|  ", -- Icon for up to date dependencies
        outdated = "|  ", -- Icon for outdated dependencies
        invalid = "|  ", -- Icon for invalid dependencies
      },
    },
    autostart = true, -- Whether to autostart when `package.json` is opened
    hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
    hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
    -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
    -- The plugin will try to auto-detect the package manager based on
    -- `yarn.lock` or `package-lock.json`. If none are found it will use the
    -- provided one, if nothing is provided it will use `pnpm`
    package_manager = "pnpm",
  },
  config = function(_, opts)
    require("package-info").setup(opts)
  end,
  keys = {
    {
      "<leader>pi",
      "<cmd>lua require('package-info').install()<CR>",
      { noremap = true, desc = "Packages install" },
    },
    {
      "<leader>pp",
      "<cmd>lua require('package-info').change_version()<CR>",
      { noremap = true, desc = "Packages change version" },
    },
    {
      "<LEADER>pt",
      "<cmd>lua require('package-info').toggle()<CR>",
      { noremap = true, desc = "Packages toggle" },
    },
    {
      "<LEADER>pu",
      "<cmd>lua require('package-info').update()<CR>",
      { noremap = true, desc = "Packages update" },
    },
    {
      "<LEADER>pd",
      "<cmd>lua require('package-info').delete()<CR>",
      { noremap = true, desc = "Packages delete" },
    },
  },
}
