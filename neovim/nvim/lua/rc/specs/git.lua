---@type LazySpec
return {
  {
    -- 行番号の部分にgitの更新・追加・削除などの情報を表示する
    'lewis6991/gitsigns.nvim',
    config = require 'pl.gitsigns'.config,
    event = { 'User UIEnterPost' },
    cmd = 'Gitsigns',
    cond = not vim.g.vscode,
  },

  {
    -- vim内でgit操作をする
    'tpope/vim-fugitive',
    config = require 'pl.fugitive'.config,
    cmd = {
      'Git',
      'G',
      'Ggrep',
      'Gclog',
    },
    cond = not vim.g.vscode,
  },

  {
    -- git diffの表示、コンフリクトの解決
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'pl.diffview'.config,
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
      'DiffviewFileHistory'
    },
    cond = not vim.g.vscode,
  },

  {
    -- Gitのブランチに関する情報を提供する。インストールされているとlightlineの該当機能が有効化される
    'itchyny/vim-gitbranch',
    lazy = true,
    -- TODO: gitsignsがあるからいらないのでは？
    -- gitsignsに変える場合、遅延読み込みが課題である(gitbranchは軽いので同期読み込みでもよい)
    cond = not vim.g.vscode,
  },

}
