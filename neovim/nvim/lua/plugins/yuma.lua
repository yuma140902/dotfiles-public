-- 開発中・自作のプラグイン
return {
  'yuma140902/auto-split-direction.nvim',
  -- dir = '~/pj/nvim/auto-split-direction.nvim',
  branch = 'master',
  cmd = 'SplitAutoDirection',
  config = function()
    require 'auto-split-direction'.setup {
      debug = false,
      ratio = 3.0
    }
  end
}
