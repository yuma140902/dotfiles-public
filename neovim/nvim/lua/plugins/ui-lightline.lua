---@type LazySpec
return {
  'https://github.com/itchyny/lightline.vim',
  cond = not vim.g.vscode,
  event = { 'User UIEnterPost' },

  init = function()
    vim.g.lightline = {
      colorscheme = 'one',
      active = {
        left = {
          { 'mode',     'paste' },
          { 'readonly', 'filename', 'modified' } },
        right = {
          { 'lineinfo' },
          { 'percent' },
          { --[['fileformat', 'fileencoding',]] 'filetype' },
        }
      },
    }
    vim.o.showmode = false
  end,

  config = function()
    vim.fn['lightline#update']()
  end

}
