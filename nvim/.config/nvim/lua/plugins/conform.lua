return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        nix = { "nixpkgs-fmt" },
        lua = { "luaformatter", "stylua", stop_after_first = true },
        css = { "prettierd", stop_after_first = true },
        elm = { "elm_format", stop_after_first = true },
        ocaml = { "ocamlformat", stop_after_first = true },
        yaml = { "yamlfix", stop_after_first = true },
        markdown = { "mdformat", stop_after_first = true },
        haskell = { "ormolu", stop_after_first = true },
        html = { "prettierd", "prettier", "biome", stop_after_first = true },
        typescript = { "eslint_d", "dprint", "prettierd", "biome", stop_after_first = true },
        javascript = { "eslint_d", "dprint", "prettierd", "biome", stop_after_first = true },
        typescriptreact = { "prettierd", "biome", stop_after_first = true },
        json = { "eslint_d", "prettierd", stop_after_first = true },
        javascriptreact = { "prettierd", "biome", stop_after_first = true },
        purescript = { "purs-tidy", stop_after_first = true },
        luals = { "stylua", stop_after_first = true },
        ["_"] = { "trim_whitespace", stop_after_first = true },
      },
      format_on_save = function(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        -- Skip formatting for package.json — LSP formatters can restore
        -- deleted dependencies due to stale document state on save.
        if bufname:match "package%.json$" then
          return false
        end
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
    }
  end,
}
