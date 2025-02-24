return {
  "chipsenkbeil/org-roam.nvim",
  tag = "0.1.1",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      tag = "0.3.7",
    },
  },
  opts = {
    directory = "~/orgfiles/org_roam_files",
    -- optional
    org_files = {
      "~/orgfiles/",
    },
  },
}
