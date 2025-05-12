return {
  "swaits/scratch.nvim",
  opts = {},
  cmd = {
    "Scratch",
    "ScratchSplit",
  },
  keys = {
    { "<leader>bs", "<cmd>Scratch<cr>", desc = "Scratch Buffer" },
    { "<leader>bS", "<cmd>ScratchSplit<cr>", desc = "Scratch Buffer (split)" },
  },
}
