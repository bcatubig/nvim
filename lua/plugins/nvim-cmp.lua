return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
        build = 'make install_jsregexp',
        opts = {
          history = true,
          delete_check_events = 'TextChanged',
        },
        config = function(_, opts)
          local luasnip = require 'luasnip'
          luasnip.setup(opts)

          -- expand current item or jump to next line
          vim.keymap.set({ 'i', 's' }, '<C-k>', function()
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { silent = true })

          -- jump backwards - move to previous item
          vim.keymap.set({ 'i', 's' }, '<C-j>', function()
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { silent = true })
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
      'lukas-reineke/cmp-under-comparator',
    },
    opts = function()
      -- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },

        sources = cmp.config.sources({
          { name = 'nvim_lua' },
          { name = 'nvim_lsp', keyword_length = 2 },
          { name = 'luasnip', keyword_length = 3 },
        }, {
          { name = 'path' },
          { name = 'buffer', keyword_length = 5 },
        }),

        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
          },
        },
        formatting = {
          -- Youtube: How to set up nice formatting for your sources.
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              buffer = '[buf]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[api]',
              path = '[path]',
              luasnip = '[snip]',
            },
          },
        },

        experimental = {
          -- I like the new menu better! Nice work hrsh7th
          native_menu = false,

          -- Let's play with this for a day or two
          ghost_text = false,
        },
      }
    end,
    config = function(_, opts)
      require('cmp').setup(opts)
    end,
  },
}
