local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({
    source = "kdheepak/lazygit.nvim",
    depends = { "nvim-lua/plenary.nvim" },
  })

  local k = vim.keymap
  k.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
end)
