return {
  'nvim-neo-tree/neo-tree.nvim',

  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        renderers = {
          file = {
            { 'icon' },
            { 'name', use_git_status_colors = true },
            { 'diagnostics' },
            { 'git_status', highlight = 'NeoTreeDimText' },
          },
        },
      },
      window = {
        mappings = {
          ['e'] = function()
            vim.cmd 'Neotree focus filesystem left'
          end,
          ['b'] = function()
            vim.cmd 'Neotree focus buffers left'
          end,
          ['g'] = function()
            vim.cmd 'Neotree focus git_status left'
          end,
        },
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function(file_path)
            vim.cmd 'Neotree close'
          end,
        },
      },
    }
  end,
  keys = {
    { '<leader>e', '<cmd>Neotree toggle=true source=filesystem position=left<cr>', desc = 'Show neotree' },
  },
}
