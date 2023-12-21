local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Keymaps for better default experience
-- See `:help keymap.set()`
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Pane Navigation
keymap.set('n', '<C-h>', '<C-w>h', opts)
keymap.set('n', '<C-j>', '<C-w>j', opts)
keymap.set('n', '<C-k>', '<C-w>k', opts)
keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Window Management
keymap.set('n', '<leader>uv', ':vsplit<cr>', { noremap = true, silent = true, desc = 'Split Vertical' })
keymap.set('n', '<leader>uh', ':split<cr>', { noremap = true, silent = true, desc = 'Split Horizontal' })

-- Indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- Comments
if vim.loop.os_uname().sysname == 'Linux' then
  vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = false })
  vim.api.nvim_set_keymap('v', '<C-_>', 'gcc', { noremap = false })
end

if vim.fn.has 'macunix' then
  vim.api.nvim_set_keymap('n', '<C-/>', 'gcc', { noremap = false })
  vim.api.nvim_set_keymap('v', '<C-/>', 'gcc', { noremap = false })
end
