local builtin = require "telescope.builtin"

local M = {}

M.buffer_fuzzy_find = function()
    builtin.current_buffer_fuzzy_find {}
end

M.grep_cursor = function()
    builtin.grep_string {}
end

M.search_string = function()
  builtin.live_grep {}
end

M.buffers = function()
    builtin.buffers {}
end

return M
