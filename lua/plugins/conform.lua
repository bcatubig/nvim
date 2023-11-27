return {
  'stevearc/conform.nvim',
  lazy = false,
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>cF',
      function()
        require('conform').format { formatters = { 'injected' } }
      end,
      mode = { 'n', 'v' },
      desc = 'Format Injected Langs',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      yaml = { 'prettier' },
      json = { 'prettier' },
      markdown = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      ['*'] = { 'codespell' },
      ['_'] = { 'trim_whitespace', 'trim_newlines' },
    },
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
  end,
}
