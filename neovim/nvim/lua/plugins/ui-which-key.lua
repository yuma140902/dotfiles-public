---@type LazySpec
return {
  -- キーマップを表示する
  'https://github.com/folke/which-key.nvim',
  lazy = false,
  config = function()
    require 'which-key'.setup {
      preset = 'helix',
      delay = 300,
    }
  end
}
