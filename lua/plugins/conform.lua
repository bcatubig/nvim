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
        sqlfluff = {
          args = { 'fix', '--force', '--dialect=postgres', '-' },
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
        sh = { 'shfmt' },
        sql = { 'sqlfluff' },
        toml = { 'taplo' },
        typescript = { 'prettier' },
        terraform = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        yaml = { 'prettier' },
        ['*'] = { 'codespell', 'trim_whitespace', 'trim_newlines' },
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
