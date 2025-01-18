return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact" },

  opts = {
    settings = {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        require("typescript-tools").setup_buffer(client, bufnr)
      end,
      tsserver_file_preferences = {
        importModuleSpecifierEnding = "js",
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        quotePreference = "auto",
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = true,
      },
      expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused", "remove_unused_imports" },
      code_lens = "all",
      disable_member_code_lens = false,
    },
  },
}
