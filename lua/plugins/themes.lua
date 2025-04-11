return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = function()
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
  { "sainnhe/everforest" },
  { "EdenEast/nightfox.nvim" },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" },
}
