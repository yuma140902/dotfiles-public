-- LSPサーバー(クライアントではない)に関するプラグイン

---@type LazySpec
return {
  {
    -- LSPサーバーの起動、デフォルト設定の提供など
    'neovim/nvim-lspconfig',
    lazy = true,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
    config = require 'pl.lspconfig'.config,
  },

  {
    -- LSP等のインストーラ
    'williamboman/mason.nvim',
    -- mason.nvimを遅延読み込みするのは非推奨だし不要である
    -- > mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended.
    lazy = false,
    config = require 'pl.mason'.config,
  },

  {
    -- masonでインストールしたサーバーのsetupを行う
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    config = require 'pl.mason-lspconfig'.config,
    event = { 'BufNewFile', 'BufReadPre', 'FilterReadPre', 'FileReadPre' }
  },

  {
    -- LSPの状態を右下に表示する
    'j-hui/fidget.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.fidget'.config,
    event = 'LspAttach'
  },

  {
    -- LSP用のUI
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    config = require 'pl.lspsaga'.config,
    event = 'LspAttach'
  },

  {
    -- Linter、Formatterを実行する
    'nvimtools/none-ls.nvim',
    config = require 'pl.none-ls'.config,
    event = { 'BufWritePre', 'FileWritePre', 'BufNewFile', 'BufReadPost', 'FileReadPost' }
  },

}
