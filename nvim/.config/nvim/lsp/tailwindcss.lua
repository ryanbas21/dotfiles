---@type vim.lsp.Config
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "astro", "html", "css", "less", "postcss", "sass", "scss",
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "svelte",
  },
  root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts" },
}
