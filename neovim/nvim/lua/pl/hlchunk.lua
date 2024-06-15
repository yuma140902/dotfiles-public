local M = {}

function M.config()
  require 'hlchunk'.setup {
    chunk = {
      enable = true,
      notify = false,
      use_treesitter = true,
      delay = 0,
    },
    indent = {
      enable = false,
    },
    line_num = {
      enable = false,
    },
    blank = {
      enable = false,
    }
  }
end

return M
