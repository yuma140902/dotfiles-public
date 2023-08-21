local M = {}

function M.config()
  require 'gitsigns'.setup {
    trouble = true,
  }
end

return M
