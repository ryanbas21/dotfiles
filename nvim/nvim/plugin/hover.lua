local ok, hover = pcall(require, "hover")
if not ok then
    return
end

hover.setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                require('hover.providers.gh')
                require('hover.providers.gh_user')
                require('hover.providers.man')
                require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = 'solid'
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = true,
            title = false
        }


