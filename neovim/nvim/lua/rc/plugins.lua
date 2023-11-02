-- プラグインに関する設定
--
-- vim: set foldmethod=marker :

-- lazy.nvim(プラグインマネージャ)を自動インストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- { 'folke/lazy.nvim' },
  -----------------------------------------------------------------------------
  -- ライブラリ {{{
  -----------------------------------------------------------------------------
  -- }}}

  -----------------------------------------------------------------------------
  -- ファイルマネージャ {{{
  -----------------------------------------------------------------------------
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = require 'pl.oil'.config,
    cmd = { 'Oil' }
  },
  -- }}}

  -----------------------------------------------------------------------------
  -- 自動補完 {{{
  -----------------------------------------------------------------------------
  {
    -- vim-vsnip
    'hrsh7th/vim-vsnip',
    dependencies = {
      { 'hrsh7th/vim-vsnip-integ',      lazy = true },
      { 'rafamadriz/friendly-snippets', lazy = true },
    },
    event = { 'InsertEnter', 'CmdlineEnter' }
  },
  {
    -- nvim-cmp
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- バッファ内の単語。普通フォールバック先として使う。ddc.vimのaroundソースに相当
      { 'hrsh7th/cmp-buffer',                  lazy = true },
      -- vsnipからの候補
      { 'hrsh7th/cmp-vsnip',                   lazy = true },
      -- lspからの候補
      { 'hrsh7th/cmp-nvim-lsp',                lazy = true },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true },
      -- ファイルパスの補完ソース
      { 'hrsh7th/cmp-path',                    lazy = true },
      -- コマンドラインでの補完ソース
      { 'hrsh7th/cmp-cmdline',                 lazy = true },
      -- カーソル位置のメソッドのシグネチャを表示する
      { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true }
    },
    init = require 'pl.nvim-cmp'.init,
    config = require 'pl.nvim-cmp'.config,
    event = { 'InsertEnter', 'CmdlineEnter' }
  },
  -- }}}

  -----------------------------------------------------------------------------
  -- 未整理 {{{
  -----------------------------------------------------------------------------
  -- etc.lua --
  {
    'navarasu/onedark.nvim', -- カラースキーム
    lazy = false,            -- メインのカラースキームは確実に非同期で読み込むようにするらしい
    priority = 1000,         -- メインのカラースキームは他のプラグインよりも先に読み込まれるのが良いらしい
    config = require 'pl.onedark'.config
  },
  -- ファイラ
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require 'nvim-tree'.setup() end,
    cmd = 'NvimTreeToggle',
  },
  -- Webページ内のテキストボックスを編集するために外部のテキストエディタを使用できるようにするブラウザアドオンGhostTextに対応するためのプラグイン
  -- Neovim側がサーバーとして動作する
  -- GhostTextを利用するためにはneovimを予め立ち上げ、:GhostTextStartでサーバーを起動させておく必要がある
  -- GhostTextとneovimはlocalhost:4001で通信する
  {
    'subnut/nvim-ghost.nvim',
    init = require 'pl.nvim-ghost'.init,
    cmd = 'GhostTextStart'
  },

  -- fuzzy_finder.lua --
  -- ファジーファインダに関するプラグイン
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- コマンドパレット(VSCodeのC-S-PあるいはF1で表示されるやつ)
      { 'LinArcX/telescope-command-palette.nvim', lazy = true },
      { 'nvim-telescope/telescope-github.nvim',   lazy = true },
      { 'debugloop/telescope-undo.nvim',          lazy = true },
    },
    config = require 'pl.telescope'.config,
    cmd = 'Telescope'
  },

  -- ide_like.lua --
  -- IDE風に操作するためのプラグイン達
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
    config = require 'pl.todo-comments'.config,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    -- キーマップを表示するやつ
    'folke/which-key.nvim',
    lazy = true, -- 初めてrequire('which-key')が実行されたときにこのプラグインが読み込まれるようになる
    config = require 'pl.which-key'.config,
  },
  {
    -- スクロールバーを表示する
    'petertriho/nvim-scrollbar',
    config = function() require 'scrollbar'.setup() end,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    'vxpm/ferris.nvim',
    config = require 'pl.ferris'.config,
    cmd = {
      "FerrisExpandMacro",
      "FerrisJoinLines",
      "FerrisViewHIR",
      "FerrisViewMIR",
      "FerrisViewMemoryLayout",
      "FerrisViewSyntaxTree",
      "FerrisViewItemTree",
      "FerrisOpenCargoToml",
      "FerrisOpenParentModule",
      "FerrisOpenDocumentation",
      "FerrisReloadWorkspace",
      "FerrisRebuildMacros",
    }
  },
  { 'mrcjkb/rustaceanvim',  lazy = true, ft = 'rust' }, -- LSPと連携してInline hintを表示するなど、いくつかの機能を追加する
  {
    'saecki/crates.nvim',
    tag = 'v0.3.0', -- TODO: バージョンを固定する必要があるのかわからない
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "BufRead Cargo.toml" },
    config = require 'pl.crates'.config,
  },
  {
    'mfussenegger/nvim-jdtls',
    lazy = true
  },
  {
    -- セッション
    -- TODO: nvim-treeのウィンドウが復元されない
    'rmagatti/auto-session',
    config = require 'pl.auto-session'.config,
  },
  {
    -- ドキュメントコメントを生成してくれるやつ
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = require 'pl.neogen'.config,
    cmd = 'Neogen'
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    'lewis6991/gitsigns.nvim',
    config = require 'pl.gitsigns'.config,
    cmd = 'Gitsigns'
  },
  {
    'tpope/vim-fugitive',
    config = function()
      -- nothing
    end,
    cmd = { 'Git' }
  },

  -- library.lua --
  -- ライブラリ的なプラグイン
  {
    -- 構文解析をしてくれるやつ。それぞれの言語用のパーサーを:TSInstallで別途インストールする必要があるので注意
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    config = require 'pl.tree-sitter'.config,
    cmd = { 'TSUpdate', 'TSEnable' },
    event = { 'BufNewFile', 'BufRead' }
  },
  { 'nvim-lua/plenary.nvim' },     -- Luaの関数集。少なくともtodo-comments.nvimが依存している
  {
    'nvim-tree/nvim-web-devicons', -- deviconに関するライブラリ。trouble.nvim, ddu-column-icon_filenameなどのアイコン表示が改善される
    lazy = true,
    config = function() require 'nvim-web-devicons'.setup() end
  },

  -- lsp.lua --
  -- LSPに関するプラグイン
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
    config = require 'pl.nvim-lspconfig'.config,
    cmd = 'Mason',
    event = { 'BufNewFile', 'BufRead' }
  },
  { 'williamboman/mason.nvim',           lazy = true },
  { 'williamboman/mason-lspconfig.nvim', lazy = true },
  {
    'j-hui/fidget.nvim', -- LSPの状態を右下に表示する
    tag = 'legacy',      -- TODO:
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.fidget'.config,
    event = 'LspAttach'
  },

  -- motion.lua --
  -- 移動に関するプラグイン
  {
    -- LSPを使ってコードアウトラインを作り、移動できるようにするプラグイン
    'stevearc/aerial.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('aerial').setup {}
    end,
    cmd = { 'AerialOpen', 'AerialPrev', 'AerialNext' }
  },
  {
    -- easy-motionみたいなやつ
    'skanehira/jumpcursor.vim',
    event = { 'BufRead' }
  },

  -- ui.lua --
  -- UIを改善するプラグイン
  {
    'itchyny/lightline.vim', -- ステータスライン TODO: lualineを試す
    dependencies = 'itchyny/vim-gitbranch',
    init = require 'pl.lightline'.init,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    'itchyny/vim-gitbranch', -- Gitのブランチに関する情報を提供する。インストールされているとlightlineの該当機能が有効化される
    lazy = true
    -- TODO: gitsignsがあるからいらないのでは？
    -- gitsignsに変える場合、遅延読み込みが課題である(gitbranchは軽いので同期読み込みでもよい)
  },
  {
    'rcarriga/nvim-notify',
    init = require 'pl.nvim-notify'.init,
  },

  -- util.lua --
  -- ユーティリティ的な小物のプラグイン
  {
    -- :Linediffコマンドで2つの選択した部分の差分を表示してくれる
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff'
  },
  {
    'norcalli/nvim-colorizer.lua', -- カラーコードに色をつける
    config = function() require 'colorizer'.setup() end,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    'cohama/lexima.vim',
    event = 'InsertEnter',
    init = require 'pl.lexima'.init,
    config = require 'pl.lexima'.config,
  },
  {
    'machakann/vim-sandwich',
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    'thinca/vim-partedit',
    cmd = 'Partedit',
    config = require 'pl.vim-partedit'.config,
  },

  -- visual.lua --
  -- バッファの見た目にかかわるプラグイン。特にカーソル位置によって見た目の変わるもの
  {
    'folke/twilight.nvim', -- 近くのメソッドだけを表示する
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = require 'pl.twilight'.config,
    cmd = 'Twilight'
  },
  --{ 'RRethy/vim-illuminate', -- カーソル下の単語をハイライトする。lsp, treesitter, 正規表現を使用して「同じ」単語を抽出する。さらに<a-n>, <a-p>で移動、<a-i>でテキストオブジェクトとして参照できる
  --config = function()
  --require 'illuminate'.configure {
  --filetypes_denylist = { 'netrw' }
  --}
  --end
  --},


  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = {
      'BufReadPre ' .. (vim.fn.expand '~'):gsub('\\', '/') .. '/OneDrive/Obsidian/main/**.md',
      'BufReadPre ' .. (vim.fn.expand '~'):gsub('\\', '/') .. '/OneDrive/Obsidian/main/**.md',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = require 'pl.obsidian'.config,
  },

  {
    'dense-analysis/ale',
    lazy = false,
    config = require 'pl.ale'.config
  },

  {
    'rbtnn/vim-ambiwidth',
    lazy = false,
  },

  {
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    ft = "lisp"
  },

  -- yuma.lua --
  -- 開発中・自作のプラグイン
  {
    'yuma140902/auto-split-direction.nvim',
    -- dir = '~/pj/nvim/auto-split-direction.nvim',
    branch = 'master',
    cmd = 'SplitAutoDirection',
    config = require 'pl.auto-split-direction'.config,
  },

  -- }}}
}

require 'lazy'.setup(plugins, {
  defaults = {
    lazy = false -- TODO: lazy = true
  }
})
