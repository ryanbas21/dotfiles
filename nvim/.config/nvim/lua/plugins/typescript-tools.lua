return {
  "pmizio/typescript-tools.nvim",
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    settings = {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        require("typescript-tools").setup_buffer(client, bufnr)
        return require("configs.lsp.handlers").on_attach(client, bufnr)
      end,
      tsserver_file_preferences = {
        includeCompletionsForImportStatements = true,
        includeCompletionsWithInsertTextCompletions = true,
        includeAutomaticOptionalChainCompletions = true,
        includePackageJsonAutoImports = "on",
        importModuleSpecifierEnding = "js",
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = true,
        quotePreference = "auto",
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = true,
      },

      expose_as_code_action = "all",
      include_completions_with_insert_text = true,
      code_lens = "all",
      disable_member_code_lens = true,
    },
  },
}
