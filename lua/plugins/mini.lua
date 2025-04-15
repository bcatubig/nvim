return {
  "echasnovski/mini.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("mini.basics").setup({
      mappings = {
        windows = true,
        move_with_alt = true,
      },
    })
    -- require("mini.starter").setup({
    --   header = "who dares wins",
    --   query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
    -- })
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.comment").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup()
    require("mini.move").setup()
    require("mini.bufremove").setup()
    require("mini.bracketed").setup()
    require("mini.git").setup()

    require("mini.diff").setup({
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    })
  end,
}
