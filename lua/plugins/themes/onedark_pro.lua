-- local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
--
-- now(function()
--   add({ source = "olimorris/onedarkpro.nvim" })
--   add({ source = "neanias/everforest-nvim" })
--   add({ source = "EdenEast/nightfox.nvim" })
--   add({ source = "folke/tokyonight.nvim" })
--   add({ source = "rose-pine/neovim" })
--   add({ source = "sainnhe/gruvbox-material" })
--   add({ source = "bluz71/vim-moonfly-colors" })
--   add({ source = "rebelot/kanagawa.nvim" })
--   add({ source = "sainnhe/sonokai" })
--   add({ source = "nyoom-engineering/oxocarbon.nvim" })
--   add({ source = "uncleTen276/dark_flat.nvim" })
--   -- add({ source = "" })
--   -- add({ source = "" })
--
--   require("onedarkpro").setup({
--     options = {
--       cursorline = true,
--       transparency = true,
--       highlight_inactive_window = true,
--     },
--   })
--
--   vim.cmd("colorscheme onedark")
-- end)

return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  lazy = false,
  opts = function()
    require("onedarkpro").setup({ options = {
      cursorline = true,
      transparency = true,
      highlight_inactive_window = true,
    } })
    vim.cmd("colorscheme onedark")
  end,
}
