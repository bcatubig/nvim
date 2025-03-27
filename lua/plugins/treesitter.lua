local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "master",
    monitor = "main",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })

  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "c",
      "css",
      "hcl",
      "html",
      "go",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "javascript",
      "jinja",
      "jinja_inline",
      "lua",
      "make",
      "sql",
      "ini",
      "proto",
      "python",
      "query",
      "vim",
      "vimdoc",
      "yaml",
      "toml",
      "json",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
end)
