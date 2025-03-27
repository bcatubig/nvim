local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({
    source = "folke/lazydev.nvim",
  })

  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "nvim-dap-ui",
    },
  })
end)
