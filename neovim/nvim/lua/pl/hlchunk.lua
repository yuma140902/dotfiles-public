local M = {}

function M.config()
  require("hlchunk").setup({
    chunk = {
      enable = true,
      notify = false,
      use_treesitter = true,
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
  })
end

return M
