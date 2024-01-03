return {
  'EdenEast/nightfox.nvim',
  priority = 1000,
  config = function()
    require('nightfox').setup {
      options = {
        colorblind = {
          enable = true,
          severity = {
            protan = 0.3,
            deutan = 0.6,
          },
        },
      },
    }
    vim.cmd [[colorscheme nordfox]]
  end,
}
