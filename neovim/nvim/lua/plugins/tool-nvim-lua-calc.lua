---@type LazySpec
return {
  'https://github.com/yuma140902/nvim-lua-calc',
  cmd = { 'LCalc' },
  init = function()
    require 'rc.keymaps'.map.n '<space>=' { '<Cmd>LCalc<CR>', desc = '電卓' }
    require 'rc.keymaps'.map.x '<space>=' { ":<C-u>'<,'>LCalc<CR>", desc = '電卓' }
  end
}
