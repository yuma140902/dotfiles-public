local M = {}

function M.config()
  require 'auto-split-direction'.setup {
    debug = false,
    ratio = 3.0
  }
end

return M
