local ok, bufferline = pcall(require, "bufferline")
if not ok then
    return
end


vim.opt.termguicolors = true

bufferline.setup{}
