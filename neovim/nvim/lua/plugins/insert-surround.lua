---@type LazySpec
return {
  -- カッコの追加・削除・置き換えなど
  'https://github.com/kylechui/nvim-surround',
  event = { 'BufNewFile', 'BufRead' },
  config = function()
    require 'nvim-surround'.setup {}
  end
}
