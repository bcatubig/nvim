-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- include plugins
require("plugins.mini")
require("plugins.nvim-tree")
require("plugins.themes")
require("plugins.lualine")
require("plugins.indentline")
require("plugins.noice")
require("plugins.autosession")
require("plugins.bufferline")
require("plugins.bufresize")
require("plugins.conform")
require("plugins.flash")
require("plugins.lazydev")
require("plugins.lazygit")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.nvim-cmp")
require("plugins.nvim-lint")
require("plugins.sleuth")
require("plugins.todo-comments")
require("plugins.treesitter")
require("plugins.trouble")
require("plugins.which-key")
