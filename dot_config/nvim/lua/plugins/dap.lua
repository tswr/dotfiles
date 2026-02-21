return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      keys = {
        { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "DAP eval", mode = { "n", "v" } },
      },
      config = function()
        local dapui = require("dapui")
        dapui.setup()
        local dap = require("dap")
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = { "debugpy", "codelldb" },
      },
    },
  },
  keys = {
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue / Start" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>dL", function() require("dap").run_last() end, desc = "Run last" },
  },
  config = function()
    local dap = require("dap")

    -- Python
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local venv = os.getenv("VIRTUAL_ENV")
          if venv then
            return venv .. "/bin/python"
          end
          return "python3"
        end,
      },
    }

    -- C/C++
    dap.configurations.c = {
      {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- Rust
    dap.configurations.rust = {
      {
        name = "Launch (target/debug)",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- .vscode/launch.json is loaded automatically by nvim-dap
  end,
}
