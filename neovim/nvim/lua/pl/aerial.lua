local M = {}

function M.config()
  local g = vim.api.nvim_create_augroup('aerial_quit', {})
  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'PersistedSavePre',
    group = g,
    callback = function()
      require 'aerial'.close_all()
    end,
  })

  require 'aerial'.setup {
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    layout = {
      max_width = { 240, 0.5 },
    },
  }
end

return M
