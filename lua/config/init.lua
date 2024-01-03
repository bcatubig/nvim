local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'config.globals'
require 'config.options'
require 'config.keymaps'
require 'config.augroups'

local opts = {
  defaults = {},
  install = {
    colorscheme = { 'nordfox' },
  },
  rtp = {
    disabled_plugins = {
      'gzip',
      'matchit',
      'matchparen',
      'netrwPlugins',
      'tarPlugin',
      'tohtml',
      'tutor',
      'zipPlugin',
    },
  },
  change_detection = {
    notify = true,
  },
}

require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.themes' },
  { import = 'plugins.langs' },
}, opts)
