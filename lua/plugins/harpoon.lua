return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
  end,
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():append()
      end,
      desc = 'Harpoon: Mark File',
    },
    {
      '<C-e>',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Harpoon: Toggle Menu',
    },
  },
}
