return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = false,
    lazy = true,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
      },
      'rafamadriz/friendly-snippets',
    },
    opts = function()
      local lsp_zero = require 'lsp-zero'
      local cmp = require 'cmp'
      local cmp_action = lsp_zero.cmp_action()
      local lspkind = require 'lspkind'
      require('luasnip.loaders.from_vscode').lazy_load()

      return {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = lspkind.cmp_format {
            mode = 'symbol',
            maxwidth = 50,
            ellipis_char = '...',
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm { select = false },
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        },
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
        },
      }
    end,
    config = function(_, opts)
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_cmp()
      local cmp = require 'cmp'
      cmp.setup(opts)
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    opts = {},
    config = function(_, opts)
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        local function add_key(key, func, desc)
          desc = 'LSP: ' .. desc
          local kmopts = { buffer = bufnr, noremap = false, desc = desc }
          vim.keymap.set('n', key, func, kmopts)
        end

        add_key('gd', vim.lsp.buf.definition, 'Goto Definition')
        add_key('K', vim.lsp.buf.hover, 'Docs')
        add_key('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        add_key('<leader>xd', vim.diagnostic.open_float, 'Diagnostics')
        add_key(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
        add_key('[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
        add_key('gr', vim.lsp.buf.references, 'References')
        add_key('gR', vim.lsp.buf.rename, 'Rename')
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, {
          buffer = bufnr,
          desc = 'LSP: Signature Help',
        })
      end)

      local icons = require 'config.icons'
      lsp_zero.set_sign_icons {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info,
      }

      local ensure_installed = {
        'lua_ls',
      }
      local handlers = {
        lsp_zero.default_setup(),
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
      }

      for server, config in pairs(opts.servers) do
        table.insert(ensure_installed, server)
        handlers[server] = function()
          require('lspconfig')[server].setup(config)
        end
      end

      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        handlers = handlers,
      }
    end,
  },
}
