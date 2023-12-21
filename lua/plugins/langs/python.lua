return {
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local path = require('mason-registry').get_package('debugpy'):get_install_path()

      local dap = require 'dap-python'
      dap.setup(path .. '/venv/bin/python')
      dap.test_runner = 'pytest'
    end,
    keys = {
      {
        '<leader>dpt',
        function()
          require('dap-python').test_method()
        end,
        desc = 'Debug Method',
        ft = 'python',
      },
      {
        '<leader>dpc',
        function()
          require('dap-python').test_class()
        end,
        desc = 'Debug Class',
        ft = 'python',
      },
    },
  },
  {
    'linux-cultist/venv-selector.nvim',
    cmd = 'VenvSelect',
    opts = function(_, opts)
      opts.dap_enabled = true
      return vim.tbl_deep_extend('force', opts, {
        name = {
          'venv',
          '.venv',
          'env',
          '.env',
        },
      })
    end,
    keys = { { '<leader>cv', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv' } },
  },
}
