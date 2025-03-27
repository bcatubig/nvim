local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "folke/flash.nvim",
  })

  require("flash").setup({})

  vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
  end, { desc = "Flash" })
end)
