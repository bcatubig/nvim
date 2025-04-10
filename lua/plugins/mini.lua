return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.basics").setup({
      mappings = {
        windows = true,
        move_with_alt = true,
      },
    })
    -- require("mini.starter").setup({})
    -- require("mini.icons").setup()
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
