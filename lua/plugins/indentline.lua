local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
later(function()
  add({
    source = "lukas-reineke/indent-blankline.nvim",
  })

  require("ibl").setup({})
end)
