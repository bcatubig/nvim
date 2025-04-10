return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    delay = 0,
    preset = "modern",
    mappings = true,
    keys = {},
    spec = {
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", group = "[G]it", mode = { "n", "v" } },
    },
  },
}
