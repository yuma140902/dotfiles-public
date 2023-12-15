local M = {}

function M.config()
  require 'aerial'.setup {
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
  }
end

return M
