local M = {}

function M.init()
  vim.g.lightline = {
    colorscheme = 'one',
    active = {
      left = {
        { 'mode',      'paste' },
        { 'gitbranch', 'readonly', 'filename', 'modified' } },
      right = {
        { 'lineinfo' },
        { 'percent' },
        { --[['fileformat', 'fileencoding',]] 'filetype' },
      }
    },
    component_function = {
      gitbranch = 'gitbranch#name',
    },
  }
  vim.o.showmode = false
end

function M.config()
  vim.fn['lightline#update']()
end

return M
