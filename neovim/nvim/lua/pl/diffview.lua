local M = {}

function M.config()
  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'PersistedSavePre',
    callback = function()
      require 'rc.lib'.close_buffers_by_filetype('DiffviewFiles')
      require 'rc.lib'.close_buffers_by_filetype('DiffviewFileHistory')
    end
  })
end

return M
