return -- lazy.nvim
{
  'm4xshen/hardtime.nvim',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    disable_mouse = false,
    disabled_filetypes = {
      'snacks*',
    },
  },
}
