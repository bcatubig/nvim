return {
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
    -- keys = {
    --   {
    --     '<tab>',
    --     function()
    --       return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
    --     end,
    --     expr = true,
    --     silent = true,
    --     mode = 'i',
    --   },
    --   {
    --     '<tab>',
    --     function()
    --       require('luasnip').jump(1)
    --     end,
    --     mode = 's',
    --   },
    --   {
    --     '<s-tab>',
    --     function()
    --       require('luasnip').jump(-1)
    --     end,
    --     mode = { 'i', 's' },
    --   },
    -- },
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
    opts = function()
      -- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'

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
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'path' },
          { name = 'buffer', keyword_length = 5 },
        }),

        sorting = {
          -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find '^_+'
              local _, entry2_under = entry2.completion_item.label:find '^_+'
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
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
              gh_issues = '[issues]',
              tn = '[TabNine]',
              eruby = '[erb]',
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
