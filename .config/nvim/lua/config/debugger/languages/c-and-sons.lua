local dap           = require('dap')

-- c debugger
dap.adapters.cppdbg = ({
  id = 'cppdbg',
  type = 'executable',
  command = '/home/felipetrost/Downloads/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
})
