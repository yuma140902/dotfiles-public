---@type LazySpec
return {
  'https://github.com/sindrets/diffview.nvim',
  cond = not vim.g.vscode,
  dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
    'DiffviewFileHistory'
  },
  config = function()
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      callback = function()
        require 'rc.util'.close_buffers_by_filetype('DiffviewFiles')
        require 'rc.util'.close_buffers_by_filetype('DiffviewFileHistory')
      end
    })
  end,
}
