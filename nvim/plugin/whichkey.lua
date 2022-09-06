local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

local mappings = {
  w = { 
    name = "workspace",
    d = "diagnostics",
    s = "symbols"
  },
  o = {
    name = "Terminal",
    t = "Toggle Term"
  },
  f = {
    n = "Refresh Notify"
  },
  n = {
    name = "Neotest and Notify Dismiss",
    w = "watch",
    x = "stop",
    n = "neotest run",
    d = "Notify Dismiss",
    l = "run last test",
    D = "run last with DAP",
    o = "Open output",
    p = "toggle neotest",
    m = "run marked test",
  },
  g = {
    name = "git",
    a = "gitsigns stage hunk",
    s = "neogit",
    r = "gitsigns reset hunk",
    p = "gitsigns preview hunk",
    u = "gitsigns undo stage hunk",
    m = "Git Messenger"
  },
  c = {
    d = "Lsp Saga show line diagnostics",
  },
  x = {
    name = "Trouble",
    x = "Trouble",
    w = "Trouble Workspace Diagnostics",
    d = "Trouble document Diagnostics",
    l = "Trouble Location List",
    q = "Trouble Quick Fix",
    R = "Trouble lsp refrences"
  },
  l = {
    name = "LSP",
    a = "Aerial toggle",
    d = "Show line diagnostics",
    l = "find and run code  lens",
    r = "Lsp Saga Rename",
    q = "run code action",
    j = "next diagnostic",
    k = "prev disagnostic",
    ['qf'] =  "code action"
  },
  b = {
    name = "file buffers",
    c = "buffer commits",
    g = "buffer make a commit",
    s = {
      e = "sort buffers by extension",
      d = "sort buffers by directory",
      t = "sort buffers by tabs",
    }
  },
  q = {
    name = "LSP Code Action",
  },
  [ "S" ] = "Search word under cursor",
  [ "s" ] = "search a string",
  [ "," ] = "Remove highlight on search",
  [';'] = "buffer fuzzy find",
  ["<leader>"] =  "Git Files"
}


wk.register(mappings, { prefix = "<leader>" })
wk.register({
  [ "a" ] = "Aerial Toggle",
  [ "1" ] = "Buffer 1",
  [ "2" ] = "Buffer 2",
  [ "3" ] = "Buffer 3",
  [ "4" ] = "Buffer 4",
  [ "5" ] = "Buffer 5",
  [ "6" ] = "Buffer 6",
  [ "7" ] = "Buffer 7",
  [ "8" ] = "Buffer 8",
  [ "9" ] = "Buffer 9",
  [ "0" ] = "Buffer Cycle Back"
}, { prefix = "<leader>"})
wk.register({
  [ "gp" ] = "Preview definition",
  [ "[e" ] = "lsp diagnostic previous",
  [ "]e" ] = "lsp diagnostic next",
  [ "]b" ] = "Buffer line cycle Prev",
  [ "[b" ] = "Buffer line cycle Next",
  [ "gh" ] = "Lsp Finder",
  [ "gT"] = "LSP signature help",
  [ "K" ] = "LSP buf Hover"

})
wk.register({
  a = {
    r = "code action range"

  }
}, { prefix = "<Leader>", mode = "v" })
