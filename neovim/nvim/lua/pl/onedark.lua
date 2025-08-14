local M = {}

function M.config()
  vim.opt.termguicolors = true
  vim.opt.cursorline = true
  require 'onedark'.setup {
    style = 'dark',
    transparent = not vim.g.neovide,
    term_colors = true,
    ending_tildes = true,
    cmp_itemkind_reverse = false,
    toggle_style_key = '<leader>t',
    code_style = {
      comments = vim.fn.has('win32') == 1 and 'bold,italic' or 'italic',
      keywords = 'bold',
      functions = 'none',
      strings = 'none',
      variables = 'none'
    },
    highlights = {
      MyNvimCmpSel = { fg = '$blue', bg = '#adc8de' },
    }
  }
  require 'onedark'.load()
end

return M
