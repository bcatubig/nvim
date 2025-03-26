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

local map = function(key, cmd, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, key, cmd, { noremap = true, silent = true, desc = desc })
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- Setup plugins below
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- colorscheme
now(function()
  add({ source = "olimorris/onedarkpro.nvim" })

  require("onedarkpro").setup({
    options = {
      cursorline = true,
      transparency = true,
      highlight_inactive_window = true,
    },
  })
  vim.cmd("colorscheme onedark")
end)

now(function()
  add({
    source = "nvim-lualine/lualine.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })

  require("lualine").setup({
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  })
end)

-- mini plugin suite
now(function()
  require("mini.basics").setup({
    mappings = {
      windows = true,
      move_with_alt = true,
    },
  })
  require("mini.starter").setup({})
  require("mini.icons").setup()
end)

later(function()
  require("mini.ai").setup({ n_lines = 500 })
  require("mini.comment").setup()
  require("mini.surround").setup()
  require("mini.pairs").setup()
  require("mini.move").setup()
  require("mini.bufremove").setup()
  require("mini.bracketed").setup()
  require("mini.git").setup()

  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
  })
end)

-- noice
now(function()
  add({
    source = "folke/noice.nvim",
    depends = {
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
    },
  })

  require("noice").setup({
    lsp = {
      signature = {
        auto_open = { enabled = false },
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,
    },
  })
end)

--
-- indent blankline
--
later(function()
  add({
    source = "lukas-reineke/indent-blankline.nvim",
  })

  require("ibl").setup({})
end)

-- autosession
now(function()
  add({
    source = "rmagatti/auto-session",
  })
  require("auto-session").setup({
    suppressed_dirs = { "~/", "~/code", "~/Downloads", "/" },
  })
end)

-- bufresize
later(function()
  add({
    source = "kwkarlwang/bufresize.nvim",
  })

  require("bufresize").setup()
end)

-- treesitter
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

-- conform
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

  map("<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, "[F]ormat Buffer")
end)

-- telescope
now(function()
  add({
    source = "nvim-telescope/telescope.nvim",
    depends = { "nvim-lua/plenary.nvim" },
    checkout = "0.1.x",
  })

  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
    },
  })

  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "ui-select")

  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
  vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
  vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
  vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
  vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
  vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
  vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
  vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

  -- Slightly advanced example of overriding default behavior and theme
  vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, { desc = "[/] Fuzzily search in current buffer" })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set("n", "<leader>s/", function()
    builtin.live_grep({
      grep_open_files = true,
      prompt_title = "Live Grep in Open Files",
    })
  end, { desc = "[S]earch [/] in Open Files" })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
  end, { desc = "[S]earch [N]eovim files" })
end)

-- lazygit
later(function()
  add({
    source = "kdheepak/lazygit.nvim",
    depends = { "nvim-lua/plenary.nvim" },
  })

  local k = vim.keymap
  k.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
end)

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

-- lazydev
later(function()
  add({
    source = "folke/lazydev.nvim",
  })

  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "nvim-dap-ui",
    },
  })
end)

-- lspconfig
now(function()
  add({
    source = "williamboman/mason-lspconfig.nvim",
    depends = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buffer, desc = "LSP: " .. desc })
      end

      map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      local function client_supports_method(client, method, bufnr)
        if vim.fn.has("nvim-0.11") == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
          end,
        })

        -- Command to toggle inline diagnostics
        vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
          local current_value = vim.diagnostic.config().virtual_text
          if current_value then
            vim.diagnostic.config({ virtual_text = false })
          else
            vim.diagnostic.config({ virtual_text = true })
          end
        end, {})

        -- Command to toggle diagnostics
        vim.api.nvim_create_user_command("DiagnosticsToggle", function()
          local current_value = vim.diagnostic.is_disabled()
          if current_value then
            vim.diagnostic.enable()
          else
            vim.diagnostic.disable()
          end
        end, {})
      end

      -- Keybinding to toggle inline diagnostics (ii)
      vim.api.nvim_set_keymap(
        "n",
        "<Leader>ii",
        ':lua vim.cmd("DiagnosticsToggleVirtualText")<CR>',
        { desc = "Toggle inline diagnostics", noremap = true, silent = true }
      )

      -- Keybinding to toggle diagnostics (id)
      vim.api.nvim_set_keymap("n", "<Leader>id", ':lua vim.cmd("DiagnosticsToggle")<CR>', { desc = "Toggle Diagnostic", noremap = true, silent = true })

      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })

  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim" },
            disable = { "missing-fields" },
          },
        },
      },
    },
    ansiblels = {},
    astro = {},
    bashls = {},
    clangd = {},
    dockerls = {},
    emmet_ls = {},
    gopls = {
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },
    },
    templ = {},
    html = {},
    htmx = {},
    cssls = {},
    tailwindcss = {},
    basedpyright = {},
    ruff = {},
    ["ruff-lsp"] = {},
    terraformls = {},
  }

  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
    } or {},
    virtual_text = {
      source = "if_many",
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  require("mason").setup({})

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    "gofumpt",
    "goimports",
    "golines",
    "gomodifytags",
    "gotests",
    "impl",
    "stylua",
    "shfmt",
    "prettier",
    "vale",
    "hadolint",
  })

  require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
    run_on_start = false,
  })

  require("mason-lspconfig").setup({
    ensure_installed = {},
    automatic_installation = false,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        require("lspconfig")[server_name].setup(server)
      end,
    },
  })
end)

-- trouble
later(function()
  add({ source = "folke/trouble.nvim" })

  require("trouble").setup({})

  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
end)

-- flash
now(function()
  add({
    source = "folke/flash.nvim",
  })

  require("flash").setup({})

  vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
  end, { desc = "Flash" })
end)

now(function()
  add({
    source = "hrsh7th/nvim-cmp",
    depends = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  })

  local cmp = require("cmp")
  local luasnip = require("luasnip")

  luasnip.config.setup({})

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    completion = { completeopt = "menu,menuone,noinsert" },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-l>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
    }),
    sources = {
      {
        name = "lazydev",
        group_index = 0,
      },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "nvim_lsp_signature_help" },
    },
  })
end)

-- nvim-tree
now(function()
  add({
    source = "nvim-tree/nvim-tree.lua",
  })
  require("nvim-tree").setup({})
end)

-- tpope/sleuth
later(function()
  add({ source = "tpope/vim-sleuth" })
end)

-- folke/todo-comments
later(function()
  add({ source = "folke/todo-comments.nvim" })

  require("todo-comments").setup({})

  vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
  end, { desc = "Next Todo Comment" })

  vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, { desc = "Next Todo Comment" })

  vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
end)

now(function()
  add({
    source = "akinsho/bufferline.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })

  require("bufferline").setup({})
end)

now(function()
  add({
    source = "nvim-tree/nvim-tree.lua",
  })

  require("nvim-tree").setup({})
  vim.keymap.set({ "n", "x" }, "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Open Filetree" })

  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      local tree_wins = {}
      local floating_wins = {}
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:match("NvimTree_") ~= nil then
          table.insert(tree_wins, w)
        end
        if vim.api.nvim_win_get_config(w).relative ~= "" then
          table.insert(floating_wins, w)
        end
      end
      if 1 == #wins - #floating_wins - #tree_wins then
        -- Should quit, so we close all invalid windows.
        for _, w in ipairs(tree_wins) do
          vim.api.nvim_win_close(w, true)
        end
      end
    end,
  })
end)

later(function()
  add({
    source = "mfussenegger/nvim-lint",
  })

  local lint = require("lint")

  lint.linters_by_ft = {
    markdown = { "vale" },
    text = { "vale" },
    dockerfile = { "hadolint" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      if vim.opt_local.modifiable:get() then
        lint.try_lint()
      end
    end,
  })
end)

-- github-preview
now(function()
  add({
    source = "OXY2DEV/markview.nvim",
  })
end)
