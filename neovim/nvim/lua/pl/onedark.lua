local M = {}

function M.config()
  vim.opt.termguicolors = true
  vim.opt.cursorline = true
  require 'onedark'.load()
end

return M
