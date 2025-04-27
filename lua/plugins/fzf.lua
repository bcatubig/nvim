return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    local ignore = { "^node_modules/", "^.git/", "^.terraform/" }

    fzf.setup({
      { "hide" },
      file_ignore_patterns = ignore,
      defaults = {
        formatter = "path.dirname_first",
      },
      oldfiles = {
        cwd_only = true,
        stat_file = true,
        include_current_session = true,
      },
      files = {
        cwd_prompt = false,
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
    })
    fzf.register_ui_select()
  end,
  keys = {
    { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "[S]earch [H]elp" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "[S]earch [K]eymaps" },
    {
      "<leader>sf",
      function()
        require("fzf-lua").files({
          git_icons = false,
          file_icons = false,
          no_headers_i = true,
          winopts = {
            preview = { hidden = "hidden" },
          },
        })
      end,
      desc = "[S]earch [F]iles",
    },
    { "<leader>sg", "<cmd>FzfLua live_grep_glob<cr>", desc = "[S]earch [G]rep" },
    { "<leader>sr", "<cmd>FzfLua live_grep_resume<cr>", desc = "[S]earch Resume" },
    {
      "<leader>s.",
      function()
        require("fzf-lua").oldfiles({
          file_icons = false,
          no_header_i = true,
          winopts = {
            preview = { hidden = "hidden" },
          },
        })
      end,
      desc = "[S]earch Recent Files",
    },
    { "<leader>sw", "<cmd>FzfLua grep_cWORD<cr>", desc = "[S]earch [W]ord" },
    { "<leader>sC", "<cmd>FzfLua colorschemes<cr>", desc = "[S]earch [C]olorschemes" },
    { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "[S]earch [C]ommands" },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").buffers({
          git_icons = false,
          file_icons = false,
          no_header_i = true,
          winopts = {
            preview = { hidden = "hidden" },
          },
        })
      end,
      desc = "[S]earch Buffers",
    },
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search current buffer" },
    {
      "<leader>gb",
      function()
        require("fzf-lua").git_branches({
          cmd = "git branch --color",
        })
      end,
      desc = "Change [G]it branch",
    },
  },
}
