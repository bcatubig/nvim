return {
  'stevearc/dressing.nvim',
  init = function()
    vim.ui.select = function(...)
      return vim.ui.select(...)
    end
  end,
  opts = {},
}
