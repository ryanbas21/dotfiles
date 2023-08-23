local ok, leetbuddy = pcall(require, "leetbuddy")

if not ok then
  return
end

leetbuddy.setup({ language = "ts" })

