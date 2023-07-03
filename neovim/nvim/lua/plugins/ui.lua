-- UIを改善するプラグイン
return {
  {
    'itchyny/lightline.vim', -- ステータスライン
    dependencies = 'itchyny/vim-gitbranch',
    init = function()
      vim.g.lightline = {
        colorscheme = 'one',
        active = {
          left = { { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' } }
        },
        component_function = {
          gitbranch = 'gitbranch#name'
        },
      }
      vim.o.showmode = false
    end,
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
    init = function()
      require 'notify'.setup {
        render = 'default',
        stages = 'slide',
        top_down = false,
      }
      vim.notify = require 'notify'
    end
  }
}
