local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
	return
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/cognusboi/workspace/instdir/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
		setupCommands = {
			{ 
				text = '-enable-pretty-printing',
				description =  'enable pretty printing',
				ignoreFailures = false 
			},
		}
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
		setupCommands = {
			{ 
				text = '-enable-pretty-printing',
				description =  'enable pretty printing',
				ignoreFailures = false 
			},
		}
  },
}

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

