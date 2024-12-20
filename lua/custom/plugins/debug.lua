-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  opt = true,
  module = { 'dap' },
  dependencies = {
    'mfussenegger/nvim-dap',

    'theHamsta/nvim-dap-virtual-text',

    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
    { 'mxsdev/nvim-dap-vscode-js', module = { 'dap-vscode-js' } },
    {
      'microsoft/vscode-js-debug',
      opt = true,
      run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'javascript',
        'typescript',
        'rust',
      },

      automatic_installation = true,
    }

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    -- require('mason-nvim-dap').setup_handlers()

    -- Basic debugging keymaps, feel free to change to your liking!
    -- vim.keymap.set('n', '<F5>', dap.show_log)
    vim.keymap.set('n', '<F8>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', 'S-<F11>', dap.step_out)

    local standardWidth = vim.api.nvim_win_get_width(0)
    local standardHeight = math.floor(vim.api.nvim_win_get_height(0) * 0.25)
    -- Dap UI setup
    vim.keymap.set('n', '<leader>db', '<cmd>DapToggleBreakpoint<CR>', { desc = 'toggle breakpoint' })
    vim.keymap.set('n', '<leader>dd', function()
      require('dapui').toggle()
    end, { desc = 'toggle debug view' })
    vim.keymap.set('n', '<leader>dc', function()
      require('dapui').float_element('console', {
        width = standardWidth,
        height = standardHeight,
        enter = true,
        position = 'bottom',
      })
    end, { desc = 'toggle float console' })
    vim.keymap.set('n', '<leader>dr', function()
      require('dapui').float_element('repl', {
        width = standardWidth,
        height = standardHeight,
        enter = true,
        position = 'bottom',
      })
    end, { desc = 'toggle float REPL' })
    vim.keymap.set('n', '<leader>dk', function()
      require('dapui').float_element('stacks', {
        width = standardWidth,
        height = standardHeight,
        enter = true,
        position = 'bottom',
      })
    end, { desc = 'toggle float stacks' })
    vim.keymap.set('n', '<leader>ds', function()
      require('dapui').float_element('scopes', {
        width = standardWidth,
        height = standardHeight,
        enter = true,
        position = 'bottom',
      })
    end, { desc = 'toggle float scopes' })
    vim.keymap.set('n', '<leader>dw', function()
      require('dapui').float_element('watches', {
        width = standardWidth,
        height = standardHeight,
        enter = true,
        position = 'bottom',
      })
    end, { desc = 'toggle float watches' })
    vim.keymap.set('n', '<leader>dx', function()
      require('dapui').float_element('breakpoints', {
        width = standardWidth,
        height = standardHeight,
        enter = true,
        position = 'bottom',
      })
    end, { desc = 'toggle float breakpoints window' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'toggle breakpoint with condition' })
    vim.keymap.set('n', '<leader>dl', '<cmd>DapShowLog<CR>', { desc = 'show log' })
    vim.keymap.set('v', '<leader>de', function()
      require('dapui').eval()
    end, { desc = 'evaluate expression' })

    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
      },
    }

    -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local jsDebuggerPath = os.getenv 'JS_DEBUG_PATH'
    require('dap-vscode-js').setup {
      -- node_path = 'node', -- Path of node executable. Defaults to $NODE_PATH, and then 'node'
      debugger_path = jsDebuggerPath, -- Path to vscode-js-debug installation.
      -- debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      -- log_file_path = '(stdpath cache)/dap_vscode_js.log' -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    }

    function custom_node_pick_process()
      require('dap.utils').pick_process { filter = '--inspect-brk' }
    end

    for _, language in ipairs { 'typescript', 'javascript' } do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = custom_node_pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }
    end

    -- RUST DEBUGGING
    local rustDebuggerPath = os.getenv 'RUST_DEBUG_PATH'
    local dap = require 'dap'
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- Change this to your path!
        command = rustDebuggerPath,
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.rust = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable bin: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
  disable = false,
}
