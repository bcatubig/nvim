local config = function()
  local wk = require 'which-key'
  wk.register {
    ['<leader>'] = {
      e = { '<cmd>Neotree toggle=true source=filesystem position=left<cr>', 'Show file explorer' },
    },
  }

  require('neo-tree').setup {
    filesystem = {
      components = {
        harpoon_index = function(config, node, state)
          local Marked = require 'harpoon.mark'
          local path = node:get_id()
          local success, index = pcall(Marked.get_index_of, path)
          if success and index and index > 0 then
            return {
              text = string.format(' 󰛢 %d', index), -- <-- Add your favorite harpoon like arrow here
              highlight = config.highlight or 'NeoTreeDirectoryIcon',
            }
          else
            return {}
          end
        end,
      },
      renderers = {
        file = {
          { 'icon' },
          { 'name', use_git_status_colors = true },
          { 'harpoon_index' }, --> This is what actually adds the component in where you want it
          { 'diagnostics' },
          { 'git_status', highlight = 'NeoTreeDimText' },
        },
      },
    },
    window = {
      mappings = {
        ['e'] = function()
          vim.cmd 'Neotree focus filesystem left'
        end,
        ['b'] = function()
          vim.cmd 'Neotree focus buffers left'
        end,
        ['g'] = function()
          vim.cmd 'Neotree focus git_status left'
        end,
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(file_path)
          vim.cmd 'Neotree close'
        end,
      },
    },
  }
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  lazy = false,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = config,
}
