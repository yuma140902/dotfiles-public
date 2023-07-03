-- 移動に関するプラグイン
return {
  {
    -- LSPを使ってコードアウトラインを作り、移動できるようにするプラグイン
    'stevearc/aerial.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('aerial').setup {
      }
    end,
    cmd = { 'AerialOpen', 'AerialPrev', 'AerialNext' }
  },
  {
    -- easy-motionみたいなやつ
    'skanehira/jumpcursor.vim',
    event = { 'BufRead' }
  }
}
