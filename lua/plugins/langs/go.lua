return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-go',
    },
    opts = {
      adapters = {
        ['neotest-go'] = {},
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'williamboman/mason.nvim',
      {
        'leoluz/nvim-dap-go',
        config = true,
        keys = {
          {
            '<leader>dgt',
            function()
              require('dap-go').debug_test()
            end,
            desc = 'Debug Test',
          },
          {
            '<leader>dgl',
            function()
              require('dap-go').debug_last_test()
            end,
            desc = 'Debug Last Test',
          },
        },
      },
    },
  },
  {
    'olexsmir/gopher.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
