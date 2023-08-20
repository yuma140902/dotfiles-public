-- ユーティリティ的な小物のプラグイン
return {
  {
    -- :Linediffコマンドで2つの選択した部分の差分を表示してくれる
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff'
  },
  {
    'norcalli/nvim-colorizer.lua', -- カラーコードに色をつける
    config = function() require 'colorizer'.setup() end,
    event = { 'BufNewFile', 'BufRead' }
  },
  {
    'cohama/lexima.vim',
    event = 'InsertEnter',
    init = function()
      vim.g.lexima_enable_basic_rules = 1
      vim.g.lexima_enable_newline_rules = 1
      vim.g.lexima_enable_endwise_rules = 1
    end,
    config = function()
      vim.cmd "call lexima#add_rule({'filetype': 'rust', 'char': '''', 'at': '&\\%#', 'input': ''''})"
      vim.cmd "call lexima#add_rule({'filetype': 'latex', 'char': '$', 'input_after': '$'})"
      vim.cmd "call lexima#add_rule({'filetype': 'latex', 'char': '$', 'at': '\\%#\\$', 'leave': 1})"
      vim.cmd "call lexima#add_rule({'filetype': 'latex', 'char': '<BS>', 'at': '\\$\\%#\\$', 'delete': 1})"
    end
  },
  {
    'machakann/vim-sandwich',
    event = { 'BufNewFile', 'BufRead' },
    config = function()
      vim.cmd "let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)"
    end
  }
}
