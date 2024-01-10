local setup_gutter_icons = function()
  local icons = require 'config.icons'
  vim.fn.sign_define('DiagnosticSignError', {
    texthl = 'DiagnosticSignError',
    text = icons.diagnostics.Error,
    numhl = '',
  })

  vim.fn.sign_define('DiagnosticSignWarn', {
    texthl = 'DiagnosticSignWarn',
    text = icons.diagnostics.Warn,
    numhl = '',
  })

  vim.fn.sign_define('DiagnosticSignHint', {
    texthl = 'DiagnosticSignHint',
    text = icons.diagnostics.Hint,
    numhl = '',
  })

  vim.fn.sign_define('DiagnosticSignInfo', {
    texthl = 'DiagnosticSignInfo',
    text = icons.diagnostics.Info,
    numhl = '',
  })

  vim.fn.sign_define('DapBreakpoint', { text = icons.dap.Breakpoint, texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition', { text = icons.dap.DapBreakpointCondition, texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointRejected', { text = icons.dap.BreakpointRejected[0], texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'DapLogPoint' })
  vim.fn.sign_define('DapStopped', { text = icons.dap.Stopped[0], texthl = 'DapStopped' })
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end,  desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,      desc = "Eval",  mode = { "n", "v" } },
      },
      opts = {
        types = true,
      },
      config = function(_, opts)
        setup_gutter_icons()

        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open {}
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close {}
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close {}
        end
      end,
    },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- which key integration
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<leader>d'] = { name = '+debug' },
        },
      },
    },

    -- mason.nvim integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = false,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          'python',
          'delve',
          'codelldb',
          'js',
          'puppet',
        },
      },
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
    { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  },

  config = function()
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  end,
}
