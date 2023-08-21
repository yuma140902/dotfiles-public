local M = {}

function M.config()
  require 'fidget'.setup {
    text = { spinner = 'dots' },
    window = { blend = 0, border = 'none' }
  }
end

return M
