local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

-- --
-- --
null_ls.setup({
  debug = true,
	sources = {
		null_ls.builtins.diagnostics.actionlint,
		null_ls.builtins.diagnostics.gitlint,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.zsh,

		null_ls.builtins.formatting.markdownlint.with({
      condition = function(utils)
        utils.root_has_file({ "*.md" })
      end
    }),
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.stylua.with({
      condition = function(utils)
        utils.root_has_file({ ".stylua" })
      end
    }),
		null_ls.builtins.formatting.elm_format.with({
      condition = function(utils)
        utils.root_has_file({ "elm.json" })
      end
    }),
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.fourmolu,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.formatting.rescript.with({
      condition = function(utils) 
        return utils.root_has_file({ "bsconfig.json" })
      end
    }),

    null_ls.builtins.hover.printenv,
    --
		null_ls.builtins.code_actions.eslint_d.with({ 
      condition = function(utils)
            return utils.root_has_file({ ".eslintrc", ".eslint.json" })
        end
    }),
    null_ls.builtins.code_actions.gitsigns
	},
  on_attach = require('lsp.on-attach')
})
