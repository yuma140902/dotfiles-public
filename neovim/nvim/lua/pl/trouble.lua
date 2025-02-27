local M = {}

function M.config()
  require 'trouble'.setup {
    auto_open = false,
    auto_close = false,
    auto_preview = false,
    auto_jump = false,
    auto_refresh = true,
    focus = true,
    restore = true,
    follow = true,
    keys = {
      ['<esc>'] = 'close',
      q = false,
    }
  }

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'PersistedSavePre',
    callback = function()
      -- close all views
      -- [feature: close all views · Issue #456 · folke/trouble.nvim](https://github.com/folke/trouble.nvim/issues/456)
      local view = require 'trouble'.close()
      while view do
        view = require 'trouble'.close()
      end
    end,
  })
end

return M
