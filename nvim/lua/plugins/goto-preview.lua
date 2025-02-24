return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  opts = {
    default_mappings = true,
  },
}
