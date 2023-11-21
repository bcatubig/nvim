return {
  'neovim/nvim-lspconfig',
  lazy = false,
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'folke/neoconf.nvim' },
  },
  opts = {},
  config = function(_, opts)
    require('neoconf').setup {}

    local lsp_zero = require 'lsp-zero'
    lsp_zero.extend_lspconfig()
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps { buffer = bufnr }
      -- keymaps
      local builtin = require 'telescope.builtin'
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
      nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
      nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', builtin.lsp_definitions, 'Type [D]efinitions')
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end)

    -- configure lsp specific server settings
    for server, config in pairs(opts.setup) do
      lsp_zero.configure(server, config)
    end

    local handlers = {
      lsp_zero.default_setup,
      lua_ls = function()
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end,
    }

    local ensure_installed = {
      'lua_ls',
    }

    local servers = opts.servers
    for server, server_opts in pairs(servers) do
      table.insert(ensure_installed, server)
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.settings then
          handlers[server] = function()
            require('lspconfig')[server].setup(server_opts)
          end
        end
      end
    end

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      handlers = handlers,
    }
  end,
}
