return {
  'ThePrimeagen/harpoon',
  lazy = false,
  config = function()
    local harpoon = require 'harpoon'
    harpoon.setup {}

    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    local wk = require 'which-key'
    wk.register {
      ['<leader>'] = {
        h = {
          name = '+harpoon',
          m = { mark.add_file, 'Harpoon: mark file' },
          l = { ui.toggle_quick_menu, 'Harpoon: toggle menu' },
        },
      },
    }
  end,
}
