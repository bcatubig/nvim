return {
  'kdheepak/lazygit.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local wk = require 'which-key'

    wk.register {
      ['<leader>'] = {
        g = {
          g = { '<cmd>LazyGit<cr>', 'LazyGit UI' },
        },
      },
    }
  end,
}
