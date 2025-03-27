local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

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
