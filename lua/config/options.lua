vim.g.autoformat = true
local opt = vim.opt

opt.completeopt = 'menu,menuone,noselect'
opt.confirm = true
opt.inccommand = 'nosplit'

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false
opt.breakindent = true
opt.shiftround = true
opt.scrolloff = 4

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.grepprg = 'rg --vimgrep'
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'

-- Appearance
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
-- opt.colorcolumn = '79,119'
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.completeopt = 'menuone,noinsert,noselect'
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.splitkeep = 'screen'
opt.pumblend = 10
opt.pumheight = 10
-- opt.list = true
opt.conceallevel = 3
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

opt.undolevels = 10000
opt.virtualedit = 'block'
vim.g.markdown_recommended_style = 0
