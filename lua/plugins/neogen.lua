return {
  'danymat/neogen',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    snippet_engine = 'luasnip',
  },
  config = function(opts)
    require('neogen').setup(opts)
    vim.keymap.set('n', '<leader>cdf', function()
      require('neogen').generate()
    end, { noremap = true, silent = true, desc = 'Neogen: Generate Docstring' })
  end,
}
