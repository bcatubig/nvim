local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "akinsho/bufferline.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })

  require("bufferline").setup({})
end)
