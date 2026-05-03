---@type LazySpec
return {
  -- ファジーファインダ
  'https://github.com/nvim-telescope/telescope.nvim',
  cond = not vim.g.vscode,
  dependencies = {
    -- GitHub CLIと連携してPRの一覧などを提供する
    { 'https://github.com/nvim-telescope/telescope-github.nvim' },
    -- undo履歴を提供する
    { 'https://github.com/debugloop/telescope-undo.nvim' },
    'https://github.com/rcarriga/nvim-notify',
    'https://github.com/nvim-lua/plenary.nvim',
  },
  cmd = 'Telescope',

  init = function()
    local map = require 'rc.keymaps'.map
    require 'which-key'.add {
      { '<space>f', group = 'Telescope' },
      { '<space>fg', group = 'Git 関係' },
      { '<space>fgh', group = 'GitHub 関係' },
      { '<space>fx', group = 'その他' },
    }
    map.n '<space>fd' { function() require 'telescope.builtin'.find_files() end, desc = 'ファイル' }
    map.n '<space>ff' { '<Cmd>Telescope find_files hidden=true<CR>', desc = 'ファイル(すべて)' }
    map.n '<space>fr' { function() require 'telescope.builtin'.live_grep() end, desc = 'Live grep' }
    map.n '<C-f>' { '<Cmd>Telescope buffers initial_mode=normal<CR>', desc = 'バッファ選択' }
    map.n '<space>fb' { function() require 'telescope.builtin'.buffers() end, desc = 'バッファ' }
    map.n '<space>fh' { function() require 'telescope.builtin'.help_tags() end, desc = 'ヘルプファイル' }
    map.n '<space>fc' { function() require 'telescope.builtin'.commands() end, desc = 'コマンド' }
    map.n '<space>fl' { function() require 'telescope.builtin'.current_buffer_fuzzy_find() end, desc = 'カレントバッファ' }
    map.n '<space>fo' { function() require 'telescope.builtin'.oldfiles({ only_cwd = true }) end, desc = '最近のファイル(カレントディレクトリ)' }
    map.n '<space>fO' { function() require 'telescope.builtin'.oldfiles({ only_cwd = false }) end, desc = '最近のファイル(全部)' }
    map.n '<space>fu' { '<Cmd>Telescope undo<CR>', desc = '履歴(Undo)' }
    map.n '<space>fghi' { '<Cmd>Telescope gh issues<CR>', desc = 'GitHub Issues' }
    map.n '<space>fghr' { '<Cmd>Telescope gh pull_request<CR>', desc = 'GitHub PR プルリクエスト : <C-f> Show modified files' }
    map.n '<space>fghg' { '<Cmd>Telescope gh gist<CR>', desc = 'GitHub Gist : <C-n> New' }
    map.n '<space>fghw' { '<Cmd>Telescope gh run<CR>', desc = 'GitHub Workflows' }
    map.n '<space>fgb' { function() require 'telescope.builtin'.git_bcommits() end, desc = 'このファイルのコミット' }
    map.n '<space>fgc' { function() require 'telescope.builtin'.git_commits() end, desc = 'コミット' }
    map.n '<space>fgB' { function() require 'telescope.builtin'.git_branches() end, desc = 'ブランチ' }
    map.n '<space>fxo' { function() require 'telescope.builtin'.vim_options() end, desc = 'Vimオプション' }
    map.n '<space>fxa' { function() require 'telescope.builtin'.autocommands() end, desc = 'auto command' }
    map.n '<space>fxk' { function() require 'telescope.builtin'.keymaps() end, desc = 'キーマップ' }
    map.n '<space>fxp' { function() require 'telescope.builtin'.pickers() end, desc = 'Pickers' }
  end,

  config = function()
    require 'telescope'.setup {
      defaults = { file_ignore_patterns = { '.git/*' } },
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = 'vertical',
          layout_config = {
            preview_height = 0.8
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ['<esc>'] = require 'telescope.actions'.close,
              ['<C-k>'] = require 'telescope.actions'.delete_buffer,
            },
            n = {
              ['<C-f>'] = require 'telescope.actions'.close,
              ['<C-k>'] = require 'telescope.actions'.delete_buffer,
            },
          },
        },
      },
    }
  end
}
