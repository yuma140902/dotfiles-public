---@type LazySpec
return {
  -- DAP
  'https://github.com/mfussenegger/nvim-dap',
  cond = not vim.g.vscode,
  cmd = {
    'DapNew',
    'DapEval',
    'DapToggleRepl',
    'DapClearBreakpoints',
    'DapToggleBreakpoint',
    'DapSetLogLevel',
    'DapShowLog',
  },

  init = function()
    local map = require 'rc.keymaps'.map
    require 'which-key'.add { '<space>b', group = 'デバッグ' }

    map.n '<F5>' { function() require 'dap'.continue() end, desc = '続行' }
    map.n '<space>bc' { function() require 'dap'.continue() end, desc = '続行' }
    map.n '<F10>' { function() require 'dap'.step_over() end, desc = 'ステップ・オーバー' }
    map.n '<space>bN' { function() require 'dap'.step_over() end, desc = 'ステップ・オーバー' }
    map.n '<F11>' { function() require 'dap'.step_into() end, desc = 'ステップ・イン' }
    map.n '<space>bn' { function() require 'dap'.step_into() end, desc = 'ステップ・イン' }
    map.n '<F12>' { function() require 'dap'.step_out() end, desc = 'ステップ・アウト' }
    map.n '<space>bp' { function() require 'dap'.step_out() end, desc = 'ステップ・アウト' }
    map.n '<space>ba' { function() require 'dap'.toggle_breakpoint() end, desc = 'ブレークポイントの切り替え' }
    map.n '<Leader>b' { function() require 'dap'.toggle_breakpoint() end, desc = 'ブレークポイントの切り替え' }
    map.n '<space>bA' { function() require 'dap'.set_breakpoint() end, desc = 'ブレークポイントの設置' }
    map.n '<Leader>B' { function() require 'dap'.set_breakpoint() end, desc = 'ブレークポイントの設置' }
    map.n '<space>bl' {
      desc = 'ログ付きのブレークポイントの設置',
      function()
        require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end,
    }
    map.n '<space>bR' { function() require 'dap'.repl.open() end, desc = 'REPLを開く' }
    map.n '<space>br' { function() require 'dap'.run_last() end, desc = '最後のデバッグセッションをもう一度実行' }
    map.nx '<space>bh' { function() require 'dap.ui.widgets'.hover() end, desc = 'ホバー' }
    map.nx '<space>bv' { function() require 'dap.ui.widgets'.preview() end, desc = 'プレビュー' }
    map.n '<space>bf' {
      desc = 'フレームを表示',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end,
    }
    map.n '<space>bs' {
      desc = 'スコープを表示',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end,
    }
    map.n '<space>bb' { function() require 'dapui'.toggle() end, desc = 'DAP UIを開く/閉じる' }
    map.n '<space>bo' { function() require 'nvim-dap-projects'.search_project_config() end, desc = 'プロジェクト固有の設定を読み込む' }
  end,

  config = function()
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
  end
}
