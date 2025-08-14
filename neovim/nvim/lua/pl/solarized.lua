local M = {}

function M.config()
  vim.o.termguicolors = true
  vim.o.background = 'light'
  require('solarized').setup {
    error_lens = {
      text = true,
      symbol = true,
    }
  }
  vim.cmd.colorscheme 'solarized'
end

return M
