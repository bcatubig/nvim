return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'ninja',
          'python',
          'rst',
          'toml',
        })
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'ruff',
        })
      end
    end,
  },
  -- {
  --   'stevearc/conform.nvim',
  --   opts = function(_, opts)
  --     if type(opts.formatters_by_ft) == 'table' then
  --       vim.tbl_deep_extend("force",opts.formatters_by_ft, {
  --         python = { 'ruff_format' },
  --       })
  --     end
  --   end,
  -- },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {},
        ruff_lsp = {},
      },
      setup = {
        ruff_lsp = {
          on_attach = function(client, bufnr)
            print 'HELLO FROM RUFF'
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
    },
    opts = {
      adapters = {
        ['neotest-python'] = {
          runner = 'pytest',
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'williamboman/mason.nvim',
    },
    keys = {
      {
        '<leader>dPt',
        function()
          require('dap-python').test_method()
        end,
        desc = 'Debug Method',
        ft = 'python',
      },
      {
        '<leader>dPc',
        function()
          require('dap-python').test_class()
        end,
        desc = 'Debug Class',
        ft = 'python',
      },
    },
    config = function()
      local path = require('mason-registry').get_package('debugpy'):get_install_path()
      require('dap-python').setup(path .. '/venv/bin/python')

      require('dap-python').test_runner = 'pytest'
      table.insert(require('dap').configurations.python, 1, {
        type = 'python',
        request = 'launch',
        name = 'pytest',
        module = 'pytest',
        args = { 'tests' },
      })
    end,
  },
}
