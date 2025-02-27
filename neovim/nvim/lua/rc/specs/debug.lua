---@type LazySpec
return {
  {
    -- DAP
    'mfussenegger/nvim-dap',
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = require 'pl.nvim-dap'.config,
  },

  {
    -- DAPのUI
    'rcarriga/nvim-dap-ui',
    lazy = true,
    config = require 'pl.nvim-dap-ui'.config,
  },

  {
    -- プロジェクト単位でデバッグ設定を管理する
    'yuma140902/nvim-dap-projects',
    lazy = true,
  },

}
