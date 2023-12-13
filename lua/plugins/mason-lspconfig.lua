local setup_gutter_icons = function()
  local icons = require 'config.icons'
  vim.fn.sign_define('DiagnosticSignError', {
    texthl = 'DiagnosticSignError',
    text = icons.diagnostics.Error,
    numhl = '',
  })

  vim.fn.sign_define('DiagnosticSignWarn', {
    texthl = 'DiagnosticSignWarn',
    text = icons.diagnostics.Warn,
    numhl = '',
  })

  vim.fn.sign_define('DiagnosticSignHint', {
    texthl = 'DiagnosticSignHint',
    text = icons.diagnostics.Hint,
    numhl = '',
  })

  vim.fn.sign_define('DiagnosticSignInfo', {
    texthl = 'DiagnosticSignInfo',
    text = icons.diagnostics.Info,
    numhl = '',
  })

  vim.fn.sign_define('DapBreakpoint', { text = icons.dap.Breakpoint, texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition', { text = icons.dap.DapBreakpointCondition, texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointRejected', { text = icons.dap.BreakpointRejected[0], texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'DapLogPoint' })
  vim.fn.sign_define('DapStopped', { text = icons.dap.Stopped[0], texthl = 'DapStopped' })
end
return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'folke/neodev.nvim',
    },
    config = function()
      require('neodev').setup()
      setup_gutter_icons()

      local servers = {
        lua_ls = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
              globals = { 'vim' },
              disable = { 'missing-fields' },
            },
          },
        },
        ansiblels = {},
        bashls = {},
        clangd = {},
        cmake = {},
        cssls = {},
        dockerls = {},
        docker_compose_language_service = {},
        emmet_ls = {},
        gopls = {
          gopls = {
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            -- usePlaceholders = true,
            -- completeUnimported = true,
            staticcheck = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
            semanticTokens = true,
          },
        },
        html = {},
        htmx = {},
        jsonls = {},
        marksman = {},
        puppet = {
          formatOnType = true,
        },
        pyright = {},
        ruff_lsp = {},
        sqlls = {},
        taplo = {},
        terraformls = {},
        tsserver = {},
        yamlls = {},
      }

      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end,
  },
}
