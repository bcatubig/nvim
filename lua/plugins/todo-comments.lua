local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({ source = "folke/todo-comments.nvim" })

  require("todo-comments").setup({})

  vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
  end, { desc = "Next Todo Comment" })

  vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, { desc = "Next Todo Comment" })

  vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
end)
