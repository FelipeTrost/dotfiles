-- local actions       = require 'telescope.actions'
-- local action_state  = require 'telescope.actions.state'
-- local builtin       = require 'telescope.builtin'
-- local finders       = require 'telescope.finders'
-- local pickers       = require 'telescope.pickers'
-- local previewers    = require 'telescope.previewers'
-- local conf          = require('telescope.config').values
--
-- local a             = require 'plenary.async'
-- local co            = coroutine
-- local actions_state = require("telescope.actions.state")
--
-- function pick_process(opts)
--     opts          = opts or {}
--
--     local results = get_processes()
--
--     local picker  = pickers.new(opts, {
--         prompt_title    = 'Dap Commands',
--         finder          = finders.new_table {
--             results = results,
--             entry_maker = function(entry)
--                 return {
--                     value = entry.pid,
--                     display = entry.name,
--                     ordinal = entry.name,
--                 }
--             end,
--         },
--         sorter          = conf.generic_sorter(),
--         attach_mappings = function(prompt_bufnr)
--             actions.select_default:replace(function()
--                 local selection = action_state.get_selected_entry()
--                 actions.close(prompt_bufnr)
--             end)
--
--             return true
--         end
--     })
--
--     picker:find()
--
--
--
--     local selected_entry = actions_state.get_selected_entry()
--     P(selected_entry)
--
--     return r;
-- end
--
-- pick_process(require("telescope.themes").get_dropdown {})
--
-- function get_processes(opts)
--     opts = opts or {}
--     local separator = ' \\+'
--
--     local get_pid = function(parts)
--         return parts[1]
--     end
--
--     local get_process_name = function(parts)
--         return table.concat({ unpack(parts, 5) }, ' ')
--     end
--
--     local output = vim.fn.system({ 'ps', 'ah', '-U', os.getenv("USER") })
--     local procs = {}
--
--     local lines = vim.split(output, '\n')
--     local nvim_pid = vim.fn.getpid()
--     for _, line in pairs(lines) do
--         if line ~= "" then -- tasklist command outputs additional empty line in the end
--             local parts = vim.fn.split(vim.fn.trim(line), separator)
--             local pid, name = get_pid(parts), get_process_name(parts)
--             pid = tonumber(pid)
--             if pid and pid ~= nvim_pid then
--                 table.insert(procs, { pid = pid, name = name })
--             end
--         end
--     end
--
--     return procs
-- end
--
-- --
-- function M.pick_process(opts)
--     opts = opts or {}
--     local label_fn = function(proc)
--         return string.format("id=%d name=%s", proc.pid, proc.name)
--     end
--     local procs = M.get_processes(opts)
--     local co = coroutine.running()
--     if co then
--         return coroutine.create(function()
--             require('dap.ui').pick_one(procs, "Select process: ", label_fn, function(choice)
--                 coroutine.resume(co, choice and choice.pid or nil)
--             end)
--         end)
--     else
--         local result = require('dap.ui').pick_one_sync(procs, "Select process: ", label_fn)
--         return result and result.pid or nil
--     end
-- end

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Debuggers
    'leoluz/nvim-dap-go',
    'mxsdev/nvim-dap-vscode-js',
  },
  config = function()
    local dap   = require 'dap'
    local dapui = require 'dapui'



    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'js-debug-adapter'
      },
    }

    -- c debugger
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/home/felipetrost/Downloads/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
    }

    -- ts/js debbuger
    -- to use this download and build https://github.com/microsoft/vscode-js-debug
    require("dap-vscode-js").setup({
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = "/usr/local/share/vscode-js-debug",                                                -- Path to vscode-js-debug installation.
      -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },       -- which adapters to register in nvim-dap
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      require("dap").configurations[language] = {

        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = function()
            return vim.fn.input('Process id > ')
          end,
          cwd = "${workspaceFolder}",
        }

      }
    end

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
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
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
