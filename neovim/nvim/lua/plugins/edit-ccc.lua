---@type LazySpec
return {
  -- カラーコードに色をつける、カラーピッカーで色を変える
  'https://github.com/uga-rosa/ccc.nvim',
  cond = not vim.g.vscode,
  event = { 'BufNewFile', 'BufReadPost', 'FilterReadPost', 'FileReadPost' },
  config = function()
    require 'ccc'.setup {
      highlighter = {
        auto_enable = true,
      },
      mappings = {
        ['<ESC>'] = require 'ccc'.mapping.quit,
        q = require 'ccc'.mapping.none,
      }
    }
  end,
}
