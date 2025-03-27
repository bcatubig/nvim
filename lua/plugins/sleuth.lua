local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({ source = "tpope/vim-sleuth" })
end)
