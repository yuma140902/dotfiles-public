local M = {}

function M.init()
  require 'notify'.setup {
    render = 'default',
    stages = 'slide',
    top_down = false,
  }
  vim.notify = require 'notify'
end

return M
