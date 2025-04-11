return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    delay = 50,
    preset = "modern",
    mappings = true,
    keys = {},
    spec = {
      { "<leader>g", group = "[G]it" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>x", group = "[T]rouble" },
    },
  },
}
