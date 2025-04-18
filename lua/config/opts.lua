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
