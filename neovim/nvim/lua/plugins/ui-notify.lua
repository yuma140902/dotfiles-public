---@type LazySpec
return {
  -- vim.notifyを置き換えていい感じの見た目にする
  'https://github.com/rcarriga/nvim-notify',
  cond = not vim.g.vscode,
  init = function()
    require 'notify'.setup {
      render = 'default',
      stages = 'slide',
      top_down = false,
    }
    vim.notify = require 'notify'
    local map = require 'rc.keymaps'.map
    map.n '<space>fn' { '<Cmd>Telescope notify initial_mode=normal<CR>', desc = '通知履歴' }
  end
}
