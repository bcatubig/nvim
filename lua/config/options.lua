local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false
opt.breakindent = true

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.colorcolumn = '79,119'
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.completeopt = 'menuone,noinsert,noselect'
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- global statusline
opt.showmode = false

-- disable nvim intro
opt.shortmess:append 'sI'

-- Behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.iskeyword:append '-'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300
