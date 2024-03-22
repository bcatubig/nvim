return {
  'nvim-neotest/neotest',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'nvim-neotest/nvim-nio',
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<leader>t'] = { name = '+test' },
        },
      },
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python',
        require 'neotest-go',
      },
    }
  end,
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run nearest test',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run all tests',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Debug nearest test',
    },
  },
}
