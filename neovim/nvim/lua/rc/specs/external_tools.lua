---@type LazySpec
return {
  {
    -- DAP
    'mfussenegger/nvim-dap',
    cmd = {
      'DapNew',
      'DapEval',
      'DapToggleRepl',
      'DapClearBreakpoints',
      'DapToggleBreakpoint',
      'DapSetLogLevel',
      'DapShowLog',
    },
    config = require 'pl.nvim-dap'.config,
  },

  {
    -- DAPのUI
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    lazy = true,
    config = require 'pl.nvim-dap-ui'.config,
  },

  {
    -- プロジェクト単位でデバッグ設定を管理する
    'yuma140902/nvim-dap-projects',
    dependencies = { 'mfussenegger/nvim-dap' },
    lazy = true,
  },

  {
    -- Linter、Formatterを実行する
    'nvimtools/none-ls.nvim',
    config = require 'pl.none-ls'.config,
    event = { 'BufWritePre', 'FileWritePre', 'BufNewFile', 'BufReadPost', 'FileReadPost' }
  },

}
