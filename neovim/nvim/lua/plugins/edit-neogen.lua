---@type LazySpec
return {
  -- ドキュメントコメントを生成する
  'https://github.com/danymat/neogen',
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter' },
  cmd = 'Neogen',

  config = function()
    require 'neogen'.setup { snippet_engine = 'vsnip' }
  end
}
