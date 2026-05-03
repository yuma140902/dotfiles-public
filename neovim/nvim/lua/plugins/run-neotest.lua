---@type LazySpec
return {
  'https://github.com/nvim-neotest/neotest',
  cond = not vim.g.vscode,
  dependencies = {
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/nvim-lua/plenary.nvim',
    { 'https://github.com/antoinemadec/FixCursorHold.nvim' },
    'https://github.com/nvim-treesitter/nvim-treesitter'
  },
  cmd = 'Neotest',

  config = function()
    require 'neotest'.setup {
      adapters = {
        require 'rustaceanvim.neotest',
      }
    }

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      callback = function()
        require 'rc.util'.close_buffers_by_filetype('neotest-summary')
      end
    })
  end
}
