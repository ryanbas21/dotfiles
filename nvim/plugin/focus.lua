local ok, focus = pcall(require, "focus")

if not ok then
  return
end

focus.setup()
