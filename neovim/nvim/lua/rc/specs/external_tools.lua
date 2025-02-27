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
    cond = not vim.g.vscode,
  },

  {
    -- DAPのUI
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    lazy = true,
    config = require 'pl.nvim-dap-ui'.config,
    cond = not vim.g.vscode,
  },

  {
    -- プロジェクト単位でデバッグ設定を管理する
    'yuma140902/nvim-dap-projects',
    dependencies = { 'mfussenegger/nvim-dap' },
    lazy = true,
    cond = not vim.g.vscode,
  },

  {
    -- フォーマット
    'stevearc/conform.nvim',
    config = require 'pl.conform'.config,
    init = require 'pl.conform'.init,
    event = { 'BufWritePre' },
    cmd = 'ConformInfo',
    cond = not vim.g.vscode,
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      { 'antoinemadec/FixCursorHold.nvim', lazy = true },
      'nvim-treesitter/nvim-treesitter'
    },
    config = require 'pl.neotest'.config,
    cmd = 'Neotest',
    cond = not vim.g.vscode,
  },

}
