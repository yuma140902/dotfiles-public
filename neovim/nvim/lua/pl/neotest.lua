local M = {}

function M.config()
  require 'neotest'.setup {
    adapters = {
      require 'rustaceanvim.neotest',
    }
  }

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'PersistedSavePre',
    callback = function()
      require 'rc.lib'.close_buffers_by_filetype('neotest-summary')
    end
  })
end

return M
