---@type LazySpec
return {
  'https://github.com/yuma140902/auto-split-direction.nvim',
  cond = not vim.g.vscode,
  cmd = 'SplitAutoDirection',
  init = function()
    require 'rc.keymaps'.map.n '<C-w>a' { '<Cmd>SplitAutoDirection<CR>', desc = 'いい感じに分割' }
  end,
  config = function()
    require 'auto-split-direction'.setup {
      debug = false,
      ratio = 3.0,
    }
  end,

}
