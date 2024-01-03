return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      sections = {
        lualine_b = { { 'b:gitsigns_head', icon = '' } },
      },
    },
  },
}
