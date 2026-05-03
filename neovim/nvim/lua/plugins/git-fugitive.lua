---@type LazySpec
return {
  'http://github.com/tpope/vim-fugitive',
  cond = not vim.g.vscode,
  cmd = { 'Git', 'G', 'Ggrep', 'Gclog' },
  init = function()
    local map = require 'rc.keymaps'.map
    require 'which-key'.add { '<space>g', group = 'fugitive' }
    map.n '<space>gg' { '<cmd>Git<cr><C-w>T', desc = 'git status' }
  end,
  config = function()
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      callback = function()
        require 'rc.util'.close_buffers_by_filetype('fugitive')
        require 'rc.util'.close_buffers_by_filetype('git')
      end
    })
  end
}
