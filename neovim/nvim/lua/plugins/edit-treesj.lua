---@type LazySpec
return {
  'https://github.com/Wansmer/treesj',
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter' },
  cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },

  init = function()
    local map = require 'rc.keymaps'.map
    require 'which-key'.add { '<space>j', group = 'Join/Split' }
    map.n '<space>jj' { '<cmd>TSJJoin<CR>', desc = 'TSJJoin' }
    map.n '<space>js' { '<cmd>TSJSplit<CR>', desc = 'TSJSplit' }
    map.n '<space>jt' { '<cmd>TSJToggle<CR>', desc = 'TSJToggle' }
  end,

  config = function()
    require 'treesj'.setup {
      use_default_keymaps = false
    }
  end
}
