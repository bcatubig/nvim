return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'puppet',
        })
      end
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        puppet = { 'puppet_lint' },
      },
    },
  },
}
