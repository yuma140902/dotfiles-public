---@type LazySpec
return {
  -- 曖昧幅文字の幅を設定する
  'https://github.com/rbtnn/vim-ambiwidth',
  lazy = false,
  init = function()
    vim.g.ambiwidth_add_list = {
      { 0xe640,  0xe640,  2 },
      { 0xea7b,  0xea83,  2 },
      { 0xea88,  0xea96,  2 },
      { 0xeb5b,  0xeb66,  2 },
      { 0xf073a, 0xf073a, 2 },
    }
  end
}
