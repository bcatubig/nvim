local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({ source = "olimorris/onedarkpro.nvim" })

  require("onedarkpro").setup({
    options = {
      cursorline = true,
      transparency = true,
      highlight_inactive_window = true,
    },
  })
  vim.cmd("colorscheme onedark")
end)
