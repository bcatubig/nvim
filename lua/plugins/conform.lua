return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff' },
        puppet = { 'puppet-lint' },
        go = { 'goimports', 'gofumpt' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        ['*'] = { 'codespell', 'write-good' },
        ['_'] = { 'trim_whitespace', 'trim_newlines' },
      },
      format = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
