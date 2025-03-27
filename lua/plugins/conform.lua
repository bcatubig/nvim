local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({
    source = "stevearc/conform.nvim",
  })

  require("conform").setup({
    notify_on_error = false,
    formatters_by_ft = {
      astro = { "prettier" },
      lua = { "stylua" },
      go = { "goimports", "gofumpt" },
      python = { "ruff_organize_imports", "ruff_format" },
      yaml = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      javascript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      toml = { "prettier" },
      terraform = { "terraform_fmt" },
      ["*"] = { "trim_newlines", "trim_whitespace" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })

  vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, { desc = "[F]ormat buffer" })
end)
