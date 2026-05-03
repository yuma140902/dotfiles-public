---@type LazySpec
return {
  -- treesitter のパーサーとクエリを提供する
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  cmd = {
    'TSInstall',
    'TSInstallFromGrammar',
    'TSUpdate',
    'TSUninstall',
    'TSLog',
  },

  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('vim-treesitter-start', { clear = true }),
      pattern = '*',
      callback = function()
        pcall(vim.treesitter.start)
      end
    })
  end,

  config = function()
    require 'nvim-treesitter'.setup {}
  end
}
