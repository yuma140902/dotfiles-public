---@type LazySpec
return {
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  cond = not vim.g.vscode,
  event = { 'User UIEnterPost' },

  init = function()
    local map = require 'rc.keymaps'.map
    map.n '[c' { function() require('treesitter-context').go_to_context() end, desc = 'コンテキストに移動' }
  end,

  config = function()
    require 'treesitter-context'.setup {
      max_lines = 1
    }
  end
}
