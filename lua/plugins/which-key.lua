local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "folke/which-key.nvim",
  })

  require("which-key").setup({
    delay = 50,
    preset = "modern",
    spec = {
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", group = "[G]it", mode = { "n", "v" } },
    },
  })
end)
