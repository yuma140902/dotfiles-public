---@type LazySpec
return {
  -- DAPのUI
  'https://github.com/rcarriga/nvim-dap-ui',
  cond = not vim.g.vscode,
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  config = function()
    require 'dapui'.setup()

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = vim.api.nvim_create_augroup('dap_quit', { clear = true }),
      callback = function()
        require 'dapui'.close {}
      end,
    })
  end,
}
