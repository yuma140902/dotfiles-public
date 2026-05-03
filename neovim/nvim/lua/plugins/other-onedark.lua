---@type LazySpec
return {
  -- カラースキーム
  'https://github.com/navarasu/onedark.nvim',
  cond = not vim.g.vscode,
  lazy = false,
  priority = 1000, -- lazy.nvim のドキュメントによるとメインのカラースキームは他のプラグインよりも先に読み込まれるのが良いらしい。
  init = function()
    vim.cmd.colorscheme 'onedark'
  end,
  config = function()
    vim.opt.termguicolors = true
    vim.opt.cursorline = true
    require 'onedark'.setup {
      style = 'darker',
      transparent = false,
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
}
