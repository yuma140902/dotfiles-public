---@type LazySpec
return {
  -- LSP や TS を使ってコードアウトラインを作り、移動できるようにするプラグイン
  'https://github.com/stevearc/aerial.nvim',
  cond = not vim.g.vscode,
  dependencies = {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-tree/nvim-web-devicons',
  },
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
  },

  init = function()
    local map = require 'rc.keymaps'.map
    map.n '<space><space>' { '<Cmd>AerialToggle float<CR>', desc = 'Aerialを開く' }
    map.n '<right>' { '<Cmd>AerialToggle! right<CR>', desc = 'Aerialを開閉' }
    map.n ']]' { '<Cmd>AerialNext<CR>', desc = 'AerialNext' }
    map.n '[[' { '<Cmd>AerialPrev<CR>', desc = 'AerialPrev' }
  end,

  config = function()
    local g = vim.api.nvim_create_augroup('aerial_quit', {})
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = g,
      callback = function()
        require 'aerial'.close_all()
      end,
    })

    require 'aerial'.setup {
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      layout = {
        max_width = { 240, 0.5 },
      },
    }
  end
}
