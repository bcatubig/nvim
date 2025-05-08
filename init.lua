vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true

require("config.lazy")
require("config.opts")
require("config.keymaps")
require("config.filetypes")

-- Disable LSP Logging
vim.lsp.set_log_level("off")
