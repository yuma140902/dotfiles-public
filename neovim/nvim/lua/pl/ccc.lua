local M = {}

function M.config()
  require 'ccc'.setup {
    highlighter = {
      auto_enable = true,
    }
  }
end

return M
