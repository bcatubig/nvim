return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters = {
        isort = {
          prepend_args = { '--sl' },
        },
        injected = { options = { ignore_errors = true } },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        html = { 'prettier' },
        css = { 'prettier' },
        go = { 'goimports', 'gofumpt' },
        markdown = { 'prettier' },
        javascript = { 'prettier' },
        json = { 'prettier' },
        puppet = { 'puppet-lint' },
        python = { 'isort', 'ruff_format' },
        typescript = { 'prettier' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
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
    },
  },
}
