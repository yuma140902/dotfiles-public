local M = {}

function M.config()
  vim.o.termguicolors = true
  vim.o.background = 'light'
  require('solarized').setup {}
  vim.cmd.colorscheme 'solarized'
end

return M
