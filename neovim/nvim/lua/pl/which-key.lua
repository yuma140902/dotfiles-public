local M = {}

function M.config()
  require 'which-key'.setup {
    preset = 'helix',
    delay = 300,
  }
end

return M
