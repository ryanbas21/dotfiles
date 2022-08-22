local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local editorconfig_checker = null_ls.builtins.diagnostics.editorconfig_checker
editorconfig_checker._opts.command = "editorconfig-checker"

null_ls.setup {
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.selene,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.credo,
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.semgrep,
        null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.diagnostics.zsh,

        null_ls.builtins.formatting.cbfmt,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.ktlint,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.elm_format,
        null_ls.builtins.formatting.fourmolu,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.rescript,

        null_ls.builtins.completion.spell,

        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.proselint,

    },
    on_attach = require "lsp.on-attach",
}
