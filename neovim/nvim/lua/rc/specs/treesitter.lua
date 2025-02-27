-- treesitter を利用するプラグイン

---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = require 'pl.tree-sitter'.config,
    cmd = {
      'TSBufDisable',
      'TSBufEnable',
      'TSBufToggle',
      'TSDisable',
      'TSEditQuery',
      'TSEditQueryUserAfter',
      'TSEnable',
      'TSInstall',
      'TSInstallInfo',
      'TSInstallSync',
      'TSModuleInfo',
      'TSToggle',
      'TSToggle',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
    },
    event = { 'BufNewFile', 'BufReadPost', 'FilterReadPre', 'FileReadPost' }
  },

  {
    -- カーソルのあるコードブロックを囲むように線を描画する
    'shellRaining/hlchunk.nvim',
    event = { 'User UIEnterPost' },
    config = require 'pl.hlchunk'.config,
    cmd = 'EnableHL'
  },

  {
    -- Treesitterの情報を元に範囲選択する
    'sustech-data/wildfire.nvim',
    event = { 'User UIEnterPost' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require 'pl.wildfire'.config
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require 'pl.treesj'.config,
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' }
  },

  {
    -- ドキュメントコメントを生成する
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require 'pl.neogen'.config,
    cmd = 'Neogen'
  },


  {
    -- カーソルのあるブロックの開始行をウィンドウ上部に表示する
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'User UIEnterPost' },
    config = require 'pl.nvim-treesitter-context'.config,
  },

  {
    -- LSPやTSを使ってコードアウトラインを作り、移動できるようにするプラグイン
    'stevearc/aerial.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.aerial'.config,
    cmd = {
      'AerialClose',
      'AerialCloseAll',
      'AerialGo',
      'AerialInfo',
      'AerialNavClose',
      'AerialNavOpen',
      'AerialNavToggle',
      'AerialNext',
      'AerialOpen',
      'AerialOpenAll',
      'AerialPrev',
      'AerialToggle',
    }
  },

}
