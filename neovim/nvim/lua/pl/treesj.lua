local M = {}

function M.config()
  require 'treesj'.setup {
    use_default_keymaps = false
  }
end

return M
