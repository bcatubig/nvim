local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "OXY2DEV/markview.nvim",
  })
end)
