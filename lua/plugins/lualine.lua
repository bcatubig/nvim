local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "nvim-lualine/lualine.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })

  require("lualine").setup({
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  })
end)
