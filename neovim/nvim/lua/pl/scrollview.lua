local M = {}

function M.config()
  require 'scrollview'.setup {
    excluded_filetypes = {}
  }
end

return M
