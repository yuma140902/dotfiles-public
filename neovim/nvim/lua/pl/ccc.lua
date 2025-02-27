local M = {}

function M.config()
  require 'ccc'.setup {
    highlighter = {
      auto_enable = true,
    },
    mappings = {
      ['<ESC>'] = require 'ccc'.mapping.quit,
      q = require 'ccc'.mapping.none,
    }
  }
end

return M
