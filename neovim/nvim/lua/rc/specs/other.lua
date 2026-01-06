---@type LazySpec
return {
  {
    -- カラースキーム
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000, -- メインのカラースキームは他のプラグインよりも先に読み込まれるのが良いらしい
    config = require 'pl.onedark'.config,
    cond = not vim.g.vscode,
  },

  {
    -- ファイルマネージャー
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.oil'.config,
    cmd = { 'Oil' },
    cond = not vim.g.vscode,
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
    event = { 'InsertEnter', 'CmdlineEnter' },
    cond = not vim.g.vscode,
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
    event = { 'InsertEnter', 'CmdlineEnter' },
    cond = not vim.g.vscode,
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
    cmd = 'Telescope',
    cond = not vim.g.vscode,
  },

  {
    -- quickfix, LSPの診断などのリストを下部にきれいに表示する
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/todo-comments.nvim' },
    config = require 'pl.trouble'.config,
    cmd = { 'Trouble' },
    cond = not vim.g.vscode,
  },

  {
    -- TODOコメントへ移動・一覧表示する
    'folke/todo-comments.nvim',
    config = require 'pl.todo-comments'.config,
    event = { 'BufNewFile', 'BufRead' },
    cond = not vim.g.vscode,
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
    event = { 'User UIEnterPost' },
    cond = not vim.g.vscode,
  },

  {
    -- セッション管理
    'olimorris/persisted.nvim',
    lazy = false,
    config = require 'pl.persisted'.config,
    cond = not vim.g.vscode,
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
    event = { 'User UIEnterPost' },
    cond = not vim.g.vscode,
  },

  {
    -- vim.notifyを置き換えていい感じの見た目にする
    'rcarriga/nvim-notify',
    init = require 'pl.nvim-notify'.init,
    cond = not vim.g.vscode,
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
    -- GitHub Copilot
    'zbirenbaum/copilot.lua',
    dependencies = { 'copilotlsp-nvim/copilot-lsp' },
    config = function()
      require 'copilot'.setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          tex = false,
          plaintex = false,
          typst = false,
        },
        nes = {
          enabled = true, -- requires copilot-lsp as a dependency
          auto_trigger = false,
          keymap = {
            accept_and_goto = '<space><CR>',
            accept = false,
            dismiss = false,
          },
        },
      }
    end,
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    cond = not vim.g.vscode,
  },

  -- Copilot LSP
  -- Needed for NES (New Editing Session)
  {
    'copilotlsp-nvim/copilot-lsp',
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
    config = function()
      require 'copilot-lsp'.setup({
        nes = {
          move_count_threshold = 3,
        }
      })

      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        callback = function()
          require 'copilot-lsp.nes'.clear()
        end
      })
    end,
    lazy = true,
  },

  {
    -- quickfixリストから置換バッファを作り、置換バッファを編集すると実際のファイルに反映される
    'thinca/vim-qfreplace',
    cmd = { 'Qfreplace' },
    cond = not vim.g.vscode,
  },

  {
    -- quickfixリストを編集できるようにする
    'itchyny/vim-qfedit',
    event = { 'BufReadPre' },
    cond = not vim.g.vscode,
  },

  {
    's-show/ft-mapper.nvim',
    config = require 'pl.ft-mapper'.config,
    event = { 'BufNewFile', 'BufRead' },
  },
}
