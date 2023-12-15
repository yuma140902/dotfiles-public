local M = {}

function M.config()
  require 'treesitter-context'.setup {
    max_lines = 1
  }
end

return M
