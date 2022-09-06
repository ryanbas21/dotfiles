local opt = vim.opt

opt.title = true
opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.shortmess = 'c'
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true

opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.completeopt = 'menu,menuone,noselect'
opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
opt.ttimeoutlen = 500
opt.pumheight = 30
opt.autoread = true


opt.shortmess:append "sI"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250
