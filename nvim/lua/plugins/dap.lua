local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

local status_dapui_ok, dapui = pcall(require, "dapui")
if not status_dapui_ok then
  return
end

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = 'python3',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Run current file',
    program = '${file}',
    pythonPath = function()
      return '/usr/bin/python3'
    end,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Run pytests',
    module = "pytest -x -v",
  },

}

dapui.setup{}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
