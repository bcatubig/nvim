local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({
    source = "kwkarlwang/bufresize.nvim",
  })

  require("bufresize").setup()
end)
