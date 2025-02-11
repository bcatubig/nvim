vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require 'config.opts'
require 'config.keymaps'
require 'config.autocmds'
require 'config.filetypes'
require 'config.lazy'

vim.cmd 'colorscheme onedark'
