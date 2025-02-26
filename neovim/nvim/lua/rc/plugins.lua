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

  {
    -- ファイルマネージャー
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.oil'.config,
    cmd = { 'Oil' }
  },

  {
    -- スニペットエンジン
    'hrsh7th/vim-vsnip',
    dependencies = {
      -- 他のプラグインとの連携
      { 'hrsh7th/vim-vsnip-integ',      lazy = true },
      -- スニペット集
      { 'rafamadriz/friendly-snippets', lazy = true },
    },
    event = { 'InsertEnter', 'CmdlineEnter' }
  },

  {
    -- 自動補完エンジン
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- バッファ内の単語の補完ソース
      { 'hrsh7th/cmp-buffer',                    lazy = true },
      -- vsnipからの候補
      { 'hrsh7th/cmp-vsnip',                     lazy = true },
      -- LSPからの候補
      { 'hrsh7th/cmp-nvim-lsp',                  lazy = true },
      -- カーソル位置のメソッドのシグネチャを表示する
      { 'hrsh7th/cmp-nvim-lsp-signature-help',   lazy = true },
      -- NeovimのLua APIの補完ソース
      { 'hrsh7th/cmp-nvim-lua',                  lazy = true },
      -- ファイルパスの補完ソース
      { 'hrsh7th/cmp-path',                      lazy = true },
      -- コマンドラインでの補完ソース
      { 'hrsh7th/cmp-cmdline',                   lazy = true },
      -- 検索を使用してドキュメントのアウトラインをもとに移動できる
      -- `/@`または`/<Tab>`
      { 'hrsh7th/cmp-nvim-lsp-document-symbol',  lazy = true },
      -- Conventional Commitsで定義されているキーワードを補完する
      { 'davidsierradz/cmp-conventionalcommits', lazy = true },
      -- コマンドの履歴と検索の履歴を補完する
      { 'dmitmel/cmp-cmdline-history',           lazy = true },
      -- GitHub Copilot
      {
        'zbirenbaum/copilot-cmp',
        lazy = true,
        dependencies = { 'zbirenbaum/copilot.lua' },
        config = function()
          require 'copilot_cmp'.setup {}
        end
      }
    },
    init = require 'pl.nvim-cmp'.init,
    config = require 'pl.nvim-cmp'.config,
    event = { 'InsertEnter', 'CmdlineEnter' }
  },
  -- }}}

  {
    -- カラースキーム
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000, -- メインのカラースキームは他のプラグインよりも先に読み込まれるのが良いらしい
    config = require 'pl.onedark'.config
  },
  {
    'echasnovski/mini.base16',
    lazy = false,
    priority = 1000,
    config = require 'pl.mini_base16'.config
  },

  {
    -- ファジーファインダ
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- GitHub CLIと連携してPRの一覧などを提供する
      { 'nvim-telescope/telescope-github.nvim', lazy = true },
      -- undo履歴を提供する
      { 'debugloop/telescope-undo.nvim',        lazy = true },
      'rcarriga/nvim-notify',
    },
    config = require 'pl.telescope'.config,
    cmd = 'Telescope'
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
    -- quickfix, LSPの診断などのリストを下部にきれいに表示する
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/todo-comments.nvim' },
    config = function() require 'trouble'.setup() end,
    cmd = { 'Trouble' },
  },

  {
    -- TODOコメントへ移動・一覧表示する
    'folke/todo-comments.nvim',
    config = require 'pl.todo-comments'.config,
    event = { 'BufNewFile', 'BufRead' },
  },

  {
    -- キーマップを表示する
    'folke/which-key.nvim',
    lazy = true, -- 初めてrequire('which-key')が実行されたときにこのプラグインが読み込まれるようになる
    config = require 'pl.which-key'.config,
  },

  {
    -- スクロールバーを表示する
    'dstein64/nvim-scrollview',
    config = require 'pl.scrollview'.config,
    event = { 'User UIEnterPost' }
  },

  {
    -- Rust Analyzerの機能をコマンドで呼び出すためのプラグイン
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

  {
    -- Rustに関する機能を追加する
    -- rust-analyzerのインストールについて:
    -- rust-analyzerのインストールはrustup、masonどちらで行なっても良い
    'mrcjkb/rustaceanvim',
    lazy = true,
    init = require 'pl.rustaceanvim'.init,
    ft = 'rust'
  },

  {
    -- クレートの情報を見たりアップデートしたりする
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "BufRead Cargo.toml" },
    config = require 'pl.crates'.config,
  },

  {
    -- lua_lsに対してNeovimのLua APIや読み込まれているプラグインのドキュメント・型を提供する
    'folke/neodev.nvim',
    -- mason-lspconfigがlua_lsの設定をするときに読み込まれる
    lazy = true,
  },

  {
    -- schemastore.orgが提供しているJSONの様々なスキーマを読み込む
    'b0o/schemastore.nvim',
    -- mason-lspconfigがjsonlsの設定をするときに読み込まれる
    lazy = true,
  },

  {
    -- pest-parser の syntax highlight
    'pest-parser/pest.vim',
    ft = 'pest'
  },

  {
    -- マークダウンのテーブルと CSV を相互変換する
    'mattn/vim-maketable',
    cmd = 'MakeTable'
  },

  {
    -- セッション管理
    'olimorris/persisted.nvim',
    lazy = false,
    config = require 'pl.persisted'.config,
  },

  {
    -- ドキュメントコメントを生成する
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require 'pl.neogen'.config,
    cmd = 'Neogen'
  },

  {
    -- 行番号の部分にgitの更新・追加・削除などの情報を表示する
    'lewis6991/gitsigns.nvim',
    config = require 'pl.gitsigns'.config,
    event = { 'User UIEnterPost' },
    cmd = 'Gitsigns'
  },

  {
    -- vim内でgit操作をする
    'tpope/vim-fugitive',
    config = require 'pl.fugitive'.config,
    cmd = { 'Git', 'G' }
  },

  {
    -- git diffの表示、コンフリクトの解決
    'sindrets/diffview.nvim',
    config = require 'pl.diffview'.config,
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
      'DiffviewFileHistory'
    }
  },

  {
    -- 構文解析
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
    -- ライブラリ
    'nvim-lua/plenary.nvim',
    lazy = true
  },

  {
    -- ライブラリ
    'nvim-neotest/nvim-nio',
    lazy = true
  },

  {
    -- deviconsを表示するためのライブラリ
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function() require 'nvim-web-devicons'.setup() end
  },

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
    -- DAP
    'mfussenegger/nvim-dap',
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = require 'pl.nvim-dap'.config,
  },

  {
    -- DAPのUI
    'rcarriga/nvim-dap-ui',
    lazy = true,
    config = require 'pl.nvim-dap-ui'.config,
  },

  {
    -- プロジェクト単位でデバッグ設定を管理する
    'yuma140902/nvim-dap-projects',
    lazy = true,
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

  {
    -- ステータスライン
    -- TODO: lualineを試す
    'itchyny/lightline.vim',
    dependencies = {
      'itchyny/vim-gitbranch',
    },
    init = require 'pl.lightline'.init,
    config = require 'pl.lightline'.config,
    event = { 'User UIEnterPost' }
  },

  {
    -- Gitのブランチに関する情報を提供する。インストールされているとlightlineの該当機能が有効化される
    'itchyny/vim-gitbranch',
    lazy = true
    -- TODO: gitsignsがあるからいらないのでは？
    -- gitsignsに変える場合、遅延読み込みが課題である(gitbranchは軽いので同期読み込みでもよい)
  },

  {
    -- vim.notifyを置き換えていい感じの見た目にする
    'rcarriga/nvim-notify',
    init = require 'pl.nvim-notify'.init,
  },

  {
    -- :Linediffコマンドで2つの選択した部分の差分を表示してくれる
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff'
  },

  {

    -- カラーコードに色をつける、カラーピッカーで色を変える
    'uga-rosa/ccc.nvim',
    config = require 'pl.ccc'.config,
    event = { 'BufNewFile', 'BufReadPost', 'FilterReadPost', 'FileReadPost' }
  },

  {
    -- 閉じカッコなどの自動入力
    'cohama/lexima.vim',
    event = 'InsertEnter',
    init = require 'pl.lexima'.init,
    config = require 'pl.lexima'.config,
  },

  {
    -- カッコの追加・削除・置き換えなど
    'kylechui/nvim-surround',
    event = { 'BufNewFile', 'BufRead' },
    config = require 'pl.surround'.config,
  },

  {
    -- バッファの一部を新しいバッファに切り出して編集できる
    -- markdownのコードブロック、Rustのdoctestなどに使える
    'thinca/vim-partedit',
    cmd = 'Partedit',
    config = require 'pl.vim-partedit'.config,
  },

  {
    -- カーソルから離れた行を暗い色で表示する
    -- treesitterにも対応
    'folke/twilight.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = require 'pl.twilight'.config,
    cmd = 'Twilight',
  },

  {
    -- 曖昧幅文字の幅を設定する
    'rbtnn/vim-ambiwidth',
    init = require 'pl.ambiwidth'.init,
    lazy = false,
  },

  {
    -- Linter、Formatterを実行する
    'nvimtools/none-ls.nvim',
    config = require 'pl.none-ls'.config,
    event = { 'BufWritePre', 'FileWritePre', 'BufNewFile', 'BufReadPost', 'FileReadPost' }
  },

  {
    -- 対応するカッコをネストの深さに応じて色分けする
    -- Lispのときだけ使用する
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    ft = "lisp"
  },

  {
    -- GitHub Copilot
    'zbirenbaum/copilot.lua',
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          tex = false,
          plaintex = false,
        }
      }
    end,
    cmd = { "Copilot" },
    event = { "InsertEnter" }
  },

  {
    -- sudoでファイルを読み書きする
    'lambdalisue/suda.vim',
    cmd = { 'SudaRead', 'SudaWrite' },
    init = require 'pl.suda'.init
  },

  {
    -- quickfixリストから置換バッファを作り、置換バッファを編集すると実際のファイルに反映される
    'thinca/vim-qfreplace',
    cmd = { 'Qfreplace' }
  },

  {
    -- quickfixリストを編集できるようにする
    'itchyny/vim-qfedit',
    event = { 'BufReadPre' }
  },

  {
    -- ウィンドウの分割方向を自動で決める
    'yuma140902/auto-split-direction.nvim',
    -- dir = '~/pj/nvim/auto-split-direction.nvim',
    branch = 'master',
    cmd = 'SplitAutoDirection',
    config = require 'pl.auto-split-direction'.config,
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
    event = { 'ModeChanged *:[vV\\x16]*' }, -- visualモードに入った時
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require 'pl.wildfire'.config
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require 'pl.treesj'.config,
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' }
  },
}

require 'lazy'.setup(plugins, {
  defaults = {
    lazy = false -- TODO: lazy = true
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/pj/nvim",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {
      'yuma140902',
      'olimorris/persisted.nvim'
    },
    fallback = true, -- Fallback to git when local plugin doesn't exist
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
})
