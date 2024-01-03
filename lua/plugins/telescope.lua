local config = function()
  local telescope = require 'telescope'
  local actions = require 'telescope.actions'

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ['<esc>'] = actions.close,
        },
      },
    },
    pickers = {
      find_files = {
        theme = 'dropdown',
        previewer = false,
        hidden = true,
      },
      live_grep = {
        theme = 'dropdown',
        previewer = false,
      },
      buffers = {
        theme = 'dropdown',
        previewer = false,
      },
    },
  }

  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers' })
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- vim.keymap.set('n', '<leader>ff', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
  vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
  -- vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
  vim.keymap.set('n', '<leader>fh', require('telescope.builtin').oldfiles, { desc = '[F]ind recently opened files' })
  vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind [G]rep' })
  vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers' })
end

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = config,
}
