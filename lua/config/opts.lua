local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.showmode = false
opt.tabstop = 2
opt.shiftround = true -- Round indent
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.signcolumn = 'yes'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
-- opt.list = true
opt.listchars = { tab = ' ▎', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.swapfile = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
