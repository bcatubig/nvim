return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  keys = {
    {
      "-",
      "<cmd>Oil --float<cr>",
      desc = "Oil Filemanager",
    },
  },
}
