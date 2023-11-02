local M = {}

function M.config()
  require 'ferris'.setup {
    create_commands = true,
    -- TODO:
    url_handler = 'xdg-open'
  }
end

return M
