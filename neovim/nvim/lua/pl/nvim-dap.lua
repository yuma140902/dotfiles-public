local M = {}

function M.config()
  require 'dap'.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb.exe',
      args = { '--port', '${port}' }
    }
  }

  require 'dap'.configurations = {
    rust = {
      {
        name = 'Debug a generic Rust program',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {}
      }
    }
  }
end

return M
