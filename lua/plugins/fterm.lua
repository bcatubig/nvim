return {
  'numToStr/FTerm.nvim',

  config = function()
    local fterm = require 'FTerm'
    fterm.setup {}

    -- add commands
    vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
    vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
    vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })
    vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
    -- keybinds
    vim.keymap.set('n', '<C-t>', '<CMD>FTermToggle<CR>', { desc = 'toggle terminal' })
    vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>FTermToggle<CR>')
  end,
}
