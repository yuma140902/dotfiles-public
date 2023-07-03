-- バッファの見た目にかかわるプラグイン。特にカーソル位置によって見た目の変わるもの
return {
  {
    'folke/twilight.nvim', -- 近くのメソッドだけを表示する
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'twilight'.setup {
        dimming = {
          alpha = 0.25
        }
      }
    end,
    cmd = 'Twilight'
  },
  --{ 'RRethy/vim-illuminate', -- カーソル下の単語をハイライトする。lsp, treesitter, 正規表現を使用して「同じ」単語を抽出する。さらに<a-n>, <a-p>で移動、<a-i>でテキストオブジェクトとして参照できる
  --config = function()
  --require 'illuminate'.configure {
  --filetypes_denylist = { 'netrw' }
  --}
  --end
  --},

}
