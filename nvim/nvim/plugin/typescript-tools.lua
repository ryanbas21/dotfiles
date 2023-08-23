local ok, ts_tools = pcall(require, "typescript-tools")
if not ok then
    return
end

ts_tools.setup {
    settings = {

        expose_as_code_action = "all",
        tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
        code_lens = "all",
    },
}
