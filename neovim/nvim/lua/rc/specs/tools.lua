---@type LazySpec
return {
  {
    -- マークダウンのテーブルと CSV を相互変換する
    'mattn/vim-maketable',
    cmd = 'MakeTable',
  },
  {
    -- :Linediffコマンドで2つの選択した部分の差分を表示してくれる
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff',
    cond = not vim.g.vscode,
  },
  {
    -- カラーコードに色をつける、カラーピッカーで色を変える
    'uga-rosa/ccc.nvim',
    config = require 'pl.ccc'.config,
    event = { 'BufNewFile', 'BufReadPost', 'FilterReadPost', 'FileReadPost' },
  },
  {
    -- バッファの一部を新しいバッファに切り出して編集できる
    -- markdownのコードブロック、Rustのdoctestなどに使える
    'thinca/vim-partedit',
    cmd = 'Partedit',
    config = require 'pl.vim-partedit'.config,
  },
  {
    -- sudoでファイルを読み書きする
    'lambdalisue/suda.vim',
    cmd = { 'SudaRead', 'SudaWrite' },
    init = require 'pl.suda'.init,
  },
  {
    -- ウィンドウの分割方向を自動で決める
    'yuma140902/auto-split-direction.nvim',
    -- dir = '~/pj/nvim/auto-split-direction.nvim',
    branch = 'master',
    cmd = 'SplitAutoDirection',
    config = require 'pl.auto-split-direction'.config,
  },

}
