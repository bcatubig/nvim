return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    { "hide", "ivy" },
    old_files = {
      cwd_only = true,
      stat_file = true,
      include_current_session = true,
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100,
      },
    },
    grep = {
      rg_glob = true,
      glob_flag = "--iglob",
      glob_separator = "%s%-%-",
    },
    files = {
      no_ignore = true,
    },
  },
  keys = {
    { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "[S]earch [H]elp" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "[S]earch [K]eymaps" },
    { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "[S]earch [F]iles" },
    { "<leader>sg", "<cmd>FzfLua live_grep_glob<cr>", desc = "[S]earch [G]rep" },
    { "<leader>sr", "<cmd>FzfLua live_grep_resume<cr>", desc = "[S]earch Resume" },
    { "<leader>s.", "<cmd>FzfLua oldfiles<cr>", desc = "[S]earch Recent Files" },
    { "<leader>sw", "<cmd>FzfLua grep_cWORD<cr>", desc = "[S]earch [W]ord" },
    { "<leader>sC", "<cmd>FzfLua colorschemes<cr>", desc = "[S]earch [C]olorschemes" },
    { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "[S]earch [C]ommands" },
    { "<leader><leader>", "<cmd>FzfLua buffers<cr>", desc = "[S]earch Buffers" },
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search current buffer" },
  },
}
