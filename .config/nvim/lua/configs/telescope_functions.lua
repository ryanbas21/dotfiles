local _bad = { ".*%.csv", ".*%.lua" } -- Put all filetypes that slow you down in this array

local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local M = {}
M.bad_files = bad_files

return M
