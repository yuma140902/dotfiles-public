local M = {}

function M.init()
  vim.g.lightline = {
    colorscheme = 'one',
    active = {
      left = { { 'mode', 'paste' },
        { 'gitbranch', 'readonly', 'filename', 'modified' } }
    },
    component_function = {
      gitbranch = 'gitbranch#name'
    },
  }
  vim.o.showmode = false
end

return M
