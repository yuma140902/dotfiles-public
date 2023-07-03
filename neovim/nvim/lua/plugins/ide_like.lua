-- IDE風に操作するためのプラグイン達
return {
  {
    -- LSP用のUI
    'kkharji/lspsaga.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require 'lspsaga'.setup() end,
    event = 'LspAttach'
  },
  {
    -- quickfix, LSPのdiagnostics, referenceなどのリストを下部にきれいに表示する
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require 'trouble'.setup() end,
    cmd = { 'TroubleToggle', 'TodoTrouble' },
  },
  {
    -- いわゆるTODOコメントへ移動・一覧表示する
    'folke/todo-comments.nvim',
    dependencies = 'folke/trouble.nvim',
    config = function() require 'todo-comments'.setup() end,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    -- キーマップを表示するやつ
    'folke/which-key.nvim',
    lazy = true, -- 初めてrequire('which-key')が実行されたときにこのプラグインが読み込まれるようになる
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require 'which-key'.setup()
    end
  },
  {
    -- スクロールバーを表示する
    'petertriho/nvim-scrollbar',
    config = function() require 'scrollbar'.setup() end,
    event = { 'BufNewFile', 'BufRead' }
  },
  { 'simrat39/rust-tools.nvim', lazy = true, ft = 'rust' }, -- LSPと連携してInline hintを表示するなど、いくつかの機能を追加する
  {
    'mfussenegger/nvim-jdtls',
    lazy = true
  },
  {
    -- セッション
    -- TODO: nvim-treeのウィンドウが復元されない
    'rmagatti/auto-session',
    config = function()
      require 'auto-session'.setup {
        log_level = 'error', -- デフォルトはinfo。うるさかったらerrorにすればよい
        auto_save_enabled = not vim.g.neovide,
        auto_restore_enabled = not vim.g.neovide,
      }
    end
  },
  {
    -- ドキュメントコメントを生成してくれるやつ
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require 'neogen'.setup { snippet_engine = 'vsnip' }
    end,
    cmd = 'Neogen'
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'gitsigns'.setup {
        trouble = true,
      }
    end,
    cmd = 'Gitsigns'
  },
  {
    'tpope/vim-fugitive',
    config = function()
      -- nothing
    end,
    cmd = { 'Git' }
  }
}
