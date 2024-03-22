local M = {}

function M.config()
  require 'scrollview'.setup {
    excluded_filetypes = {},
    winblend = 0,
  }
end

return M
