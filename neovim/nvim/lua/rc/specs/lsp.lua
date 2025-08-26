-- LSPサーバー(クライアントではない)に関するプラグイン

---@type LazySpec
return {
  {
    -- デフォルト設定の提供
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim'
    },
    config = require 'pl.lspconfig'.config,
    cond = not vim.g.vscode,
  },

  {
    -- LSP等のインストーラ
    'mason-org/mason.nvim',
    -- mason.nvimを遅延読み込みするのは非推奨だし不要である
    -- > mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended.
    lazy = false,
    config = require 'pl.mason'.config,
    cond = not vim.g.vscode,
  },

  {
    -- masonでインストールしたサーバーのsetupを行う
    'mason-org/mason-lspconfig.nvim',
    lazy = true,
    config = require 'pl.mason-lspconfig'.config,
    event = { 'BufNewFile', 'BufReadPre', 'FilterReadPre', 'FileReadPre' },
    cond = not vim.g.vscode,
  },

  {
    -- LSPの状態を右下に表示する
    'j-hui/fidget.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.fidget'.config,
    event = 'LspAttach',
    cond = not vim.g.vscode,
  },

  {
    -- LSP用のUI
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    config = require 'pl.lspsaga'.config,
    event = 'LspAttach',
    cond = not vim.g.vscode,
  },

}
