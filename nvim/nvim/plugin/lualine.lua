local deps_ok, lualine = pcall(function()
    return require "lualine"
end)
if not deps_ok then
    return
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local function attached_clients()
    return "(" .. vim.tbl_count(vim.lsp.buf_get_clients(0)) .. ")"
end

local function cwd()
    return vim.fn.fnamemodify(vim.loop.cwd(), ":~")
end

lualine.setup {
    options = {
        disabled_filetypes = { "neo-tree" },
    },
    sections = {
        lualine_b = { "branch", { "diff", cwd, source = diff_source } },
        lualine_c = {},
        lualine_x = {
            { "diagnostics", sources = { "nvim_diagnostic" } },
            "filesize",
            "encoding",
            { "filetype", separator = { right = "" }, right_padding = 0 },
            { attached_clients, separator = { left = "" }, left_padding = 0 },
        },
    },
    inactive_sections = {},
    extensions = { "quickfix", "toggleterm", "fugitive" },
}
