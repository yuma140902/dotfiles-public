local M = {}

function M.config()
  require 'ferris'.setup {
    create_commands = true,
    url_handler = function(url)
      vim.ui.open(url)
    end
  }
end

return M
