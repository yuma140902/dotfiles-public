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
    -- ウィンドウスタイル(split window style)のファイルマネージャー
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = require 'pl.oil'.config,
    cmd = { 'Oil' }
  },

  {
    -- スニペット
    'hrsh7th/vim-vsnip',
    dependencies = {
      { 'hrsh7th/vim-vsnip-integ',      lazy = true },
      { 'rafamadriz/friendly-snippets', lazy = true },
    },
    event = { 'InsertEnter', 'CmdlineEnter' }
  },
  {
    -- 自動補完
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- バッファ内の単語。普通フォールバック先として使う。ddc.vimのaroundソースに相当
      { 'hrsh7th/cmp-buffer',                    lazy = true },
      -- vsnipからの候補
      { 'hrsh7th/cmp-vsnip',                     lazy = true },
      -- lspからの候補
      { 'hrsh7th/cmp-nvim-lsp',                  lazy = true },
      { 'hrsh7th/cmp-nvim-lsp-signature-help',   lazy = true },
      -- NeovimのLua APIの補完ソース
      { 'hrsh7th/cmp-nvim-lua',                  lazy = true },
      -- ファイルパスの補完ソース
      { 'hrsh7th/cmp-path',                      lazy = true },
      -- コマンドラインでの補完ソース
      { 'hrsh7th/cmp-cmdline',                   lazy = true },
      -- カーソル位置のメソッドのシグネチャを表示する
      { 'hrsh7th/cmp-nvim-lsp-signature-help',   lazy = true },
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
    -- ブラウザのテキストボックスに入力する
    -- Neovim側がサーバーとして動作する
    -- GhostTextを利用するためにはneovimを予め立ち上げ、:GhostTextStartでサーバーを起動させておく必要がある
    -- GhostTextとneovimはlocalhost:4001で通信する
    'subnut/nvim-ghost.nvim',
    init = require 'pl.nvim-ghost'.init,
    cmd = 'GhostTextStart'
  },

  {
    -- ファジーファインダ
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

  {
    -- LSP用のUI
    'nvimdev/lspsaga.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.lspsaga'.config,
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
    'dstein64/nvim-scrollview',
    config = require 'pl.scrollview'.config,
    event = { 'CursorHold', 'CursorHoldI' }
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
    -- rust-analyzerのインストールについて
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
    -- lua_lsに対してneovimのLua APIや読み込まれているプラグインのドキュメント・型を提供する
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
    -- セッション管理
    'olimorris/persisted.nvim',
    lazy = false,
    config = require 'pl.persisted'.config,
  },

  {
    -- ドキュメントコメントを生成する
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = require 'pl.neogen'.config,
    cmd = 'Neogen'
  },

  {
    -- 行番号の部分にgitの更新・追加・削除などの情報を表示する
    'lewis6991/gitsigns.nvim',
    config = require 'pl.gitsigns'.config,
    event = { 'CursorHold', 'CursorHoldI' },
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
    'nvim-lua/plenary.nvim'
  },

  {
    -- deviconsを表示するためのプラグイン(ライブラリ)
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
    tag = 'legacy', -- TODO: mainブランチに移行する
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
    -- カーソルのあるクラスやメソッドをウィンドウの上に表示する
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'CursorHold', 'CursorHoldI' },
    config = require 'pl.nvim-treesitter-context'.config,
  },


  {
    -- LSP/TSを使ってコードアウトラインを作り、移動できるようにするプラグイン
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
    -- easy-motionみたいなやつ
    'skanehira/jumpcursor.vim',
    event = { 'BufRead' }
  },

  {
    -- ステータスライン
    -- TODO: lualineを試す
    'itchyny/lightline.vim',
    dependencies = 'itchyny/vim-gitbranch',
    init = require 'pl.lightline'.init,
    event = { 'BufNewFile', 'BufReadPost', 'BufAdd', 'FileReadPost', 'FilterReadPost' }
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
    -- カラーコードに色をつける
    'norcalli/nvim-colorizer.lua',
    config = function() require 'colorizer'.setup() end,
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
    'machakann/vim-sandwich',
    event = { 'BufNewFile', 'BufRead' }
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

  --{ 'RRethy/vim-illuminate', -- カーソル下の単語をハイライトする。lsp, treesitter, 正規表現を使用して「同じ」単語を抽出する。さらに<a-n>, <a-p>で移動、<a-i>でテキストオブジェクトとして参照できる
  --config = function()
  --require 'illuminate'.configure {
  --filetypes_denylist = { 'netrw' }
  --}
  --end
  --},

  {
    -- Obsidian関係の機能を追加する
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
    -- 曖昧幅文字の幅を設定する
    'rbtnn/vim-ambiwidth',
    lazy = false,
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

  -- }}}
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
