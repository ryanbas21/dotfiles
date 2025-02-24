return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  dependencies = {
    "dhruvasagar/vim-table-mode",
  },
  opts = {
    org_agenda_files = "~/orgfiles/**/*",
    org_default_notes_file = "~/orgfiles/refile.org",
    org_capture_templates = {
      r = {
        description = "Repo",
        template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
        target = "~/orgfiles/repos.org",
      },
      T = {
        description = "Todo",
        template = "* TODO %?\n %u",
        target = "~/orgfiles/todos.org",
      },
      j = {
        description = "Journal",
        template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
        target = "~/orgfiles/journal.org",
      },
    },
  },
}
