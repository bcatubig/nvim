return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          cursorline = true,
          transparency = true,
          highlight_inactive_windows = true,
        },
      })
      vim.cmd("colorscheme onedark")
    end,
  },
  { "sainnhe/everforest", priority = 1000 },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "nyoom-engineering/oxocarbon.nvim", priority = 1000 },
  { "bluz71/vim-moonfly-colors", name = "moonfly", priority = 1000 },
}
