local M = {}

function M.config()
  local exe_suffix = vim.fn.has('win32') == 1 and '.exe' or ''

  local g = vim.api.nvim_create_augroup('dap_quit', {})
  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'PersistedSavePre',
    group = g,
    callback = function()
      require 'dapui'.close {}
    end,
  })

  require 'dap'.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.exepath 'codelldb',
      args = { '--port', '${port}' }
    }
  }

  require 'dap'.configurations = {
    rust = {
      {
        name = '[CodeLLDB] Debug generic Rust program',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {}
      }
    },

    cpp = {
      {
        name = '[CodeLLDB] Debug generic C++ program',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {}
      }
    },

    c = {
      {
        name = '[CodeLLDB] Debug generic C program',
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
  require 'nvim-dap-projects'.search_project_config()
end

return M
