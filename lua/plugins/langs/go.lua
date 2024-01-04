return {
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap = require 'dap-go'
      dap.setup {}
    end,
    keys = {
      {
        '<leader>dgt',
        function()
          require('dap-go').debug_test()
        end,
        desc = 'Debug test',
        ft = 'go',
      },
      {
        '<leader>dgl',
        function()
          require('dap-go').debug_last_test()
        end,
        desc = 'Debug last test',
        ft = 'go',
      },
    },
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
