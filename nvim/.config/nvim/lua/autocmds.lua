local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Treesitter Patch --------------------------------------------------------
-- Neovim 0.12 crash: node:range() on nil/invalid nodes
-- See: languagetree.lua:196 "attempt to call method 'range' (a nil value)"
do
  local original_get_range = vim.treesitter.get_range
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.treesitter.get_range = function(node, source, metadata)
    if not node or not node.range then
      return { 0, 0, 0, 0, 0, 0 }
    end
    return original_get_range(node, source, metadata)
  end
end

-- File Post ----------------------------------------------------------------
-- User event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = augroup("user/file-post", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "user/file-post"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Linting ------------------------------------------------------------------
autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
  group = augroup("user/linting", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})

-- Quickfix -----------------------------------------------------------------
autocmd("QuickFixCmdPost", {
  group = augroup("user/quickfix", { clear = true }),
  callback = function()
    vim.cmd [[Trouble qflist open]]
  end,
})

-- CodeCompanion ------------------------------------------------------------
autocmd("User", {
  group = augroup("user/codecompanion", { clear = true }),
  callback = function(request)
    if request.match == "CodeCompanionInlineFinished" then
      require("conform").format { bufnr = request.buf }
    end
  end,
})
