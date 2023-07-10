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
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "BufRead Cargo.toml" },
    config = function()
      require 'crates'.setup()

      -- nvim-cmpソースの追加
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          require 'cmp'.setup.buffer({ sources = { { name = "crates" } } })
        end,
      })

      -- キーマップの追加
      local crates = require('crates')

      vim.keymap.set('n', '<space>ct', crates.toggle, { silent = true, desc = 'Toggle' })
      vim.keymap.set('n', '<space>cr', crates.reload, { silent = true, desc = 'Reload' })

      vim.keymap.set('n', '<space>cv', crates.show_versions_popup, { silent = true, desc = 'Show versions popup' })
      vim.keymap.set('n', '<space>cf', crates.show_features_popup, { silent = true, desc = 'Show features popup' })
      vim.keymap.set('n', '<space>cd', crates.show_dependencies_popup,
        { silent = true, desc = 'Show dependencies popup' })

      vim.keymap.set('n', '<space>cu', crates.update_crate, { silent = true, desc = 'Update crate' })
      vim.keymap.set('v', '<space>cu', crates.update_crates, { silent = true, desc = 'Update crates' })
      vim.keymap.set('n', '<space>ca', crates.update_all_crates, { silent = true, desc = 'Update ALL crates' })
      vim.keymap.set('n', '<space>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade crate' })
      vim.keymap.set('v', '<space>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade crates' })
      vim.keymap.set('n', '<space>cA', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade ALL crates' })

      --vim.keymap.set('n', '<space>ce', crates.expand_plain_crate_to_inline_table, {silent = true})
      --vim.keymap.set('n', '<space>cE', crates.extract_crate_into_table, {silent = true})

      vim.keymap.set('n', '<space>cH', crates.open_homepage, { silent = true, desc = 'Open homepage' })
      vim.keymap.set('n', '<space>cR', crates.open_repository, { silent = true, desc = 'Open repo' })
      vim.keymap.set('n', '<space>cD', crates.open_documentation, { silent = true, desc = 'Open doc' })
      vim.keymap.set('n', '<space>cC', crates.open_crates_io, { silent = true, desc = 'Open crates.io' })
    end
  },
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
