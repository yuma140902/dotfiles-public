-- ユーティリティ的な小物のプラグイン
return {
  {
    -- :Linediffコマンドで2つの選択した部分の差分を表示してくれる
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff'
  },
  {
    'norcalli/nvim-colorizer.lua', -- カラーコードに色をつける
    config = function() require 'colorizer'.setup() end,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    'mattn/vim-lexiv',
    event = 'InsertEnter'
  },
}
