return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  opts = {},
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon Add',
    },
    {
      '<C-e>',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
    },
    {
      '<C-P>',
      function()
        require('harpoon'):list():next()
      end,
    },
    {
      '<C-N>',
      function()
        require('harpoon'):list():prev()
      end,
    },
  },
}
