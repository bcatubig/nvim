local opt = vim.opt

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.relativenumber = true

opt.laststatus = 3
opt.timeoutlen = 300
opt.updatetime = 250
opt.swapfile = false
opt.inccommand = "split"
opt.confirm = true
opt.termguicolors = true
-- opt.winborder = "rounded"

vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- disable inline dignostic messages
vim.diagnostic.config({ virtual_text = false })

opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
