return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  },
}

-- local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
--
-- now(function()
--   add({
--     source =
--     depends = {  },
--   })
--
--   require("lualine").setup()
-- end)
