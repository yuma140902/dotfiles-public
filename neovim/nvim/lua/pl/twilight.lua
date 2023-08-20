local M = {}

function M.config()
  require 'twilight'.setup {
    dimming = {
      alpha = 0.25
    }
  }
end

return M
