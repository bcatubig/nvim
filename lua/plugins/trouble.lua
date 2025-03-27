local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({ source = "folke/trouble.nvim" })

  require("trouble").setup({})

  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
end)
