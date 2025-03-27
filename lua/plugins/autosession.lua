local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "rmagatti/auto-session",
  })
  require("auto-session").setup({
    suppressed_dirs = { "~/", "~/code", "~/Downloads", "/" },
  })
end)
