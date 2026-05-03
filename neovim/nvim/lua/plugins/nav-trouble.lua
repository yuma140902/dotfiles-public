---@type LazySpec
return {
  -- quickfix, 診断などのリストを下部にきれいに表示する
  'https://github.com/folke/trouble.nvim',
  cond = not vim.g.vscode,
  dependencies = {
    'https://github.com/nvim-tree/nvim-web-devicons',
    --'https://github.com/folke/todo-comments.nvim',
  },
  cmd = { 'Trouble' },

  init = function()
    local map = require 'rc.keymaps'.map
    require 'which-key'.add { '<space>l', group = 'trouble.nvim' }
    map.n '<space>lw' { '<Cmd>Trouble diagnostics toggle<CR>', desc = 'プロジェクト全体の診断情報' }
    map.n '<space>ll' { '<Cmd>Trouble loclist toggle<CR>', desc = 'loclist' }
    map.n '<space>lq' { '<Cmd>Trouble quickfix toggle<CR>', desc = 'QuickFix' }
  end,

  config = function()
    require 'trouble'.setup {
      auto_open = false,
      auto_close = false,
      auto_preview = false,
      auto_jump = false,
      auto_refresh = true,
      focus = true,
      restore = true,
      follow = true,
      keys = {
        ['<ESC>'] = 'close',
        q = false,
      }
    }

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      callback = function()
        -- close all views
        -- [feature: close all views · Issue #456 · folke/trouble.nvim](https://github.com/folke/trouble.nvim/issues/456)
        local view = require 'trouble'.close()
        while view do
          view = require 'trouble'.close()
        end
      end,
    })
  end
}
