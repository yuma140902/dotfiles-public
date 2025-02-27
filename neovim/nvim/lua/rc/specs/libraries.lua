---@type LazySpec
return {
  {
    'nvim-lua/plenary.nvim',
    lazy = true
  },
  {
    'nvim-neotest/nvim-nio',
    lazy = true
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function() require 'nvim-web-devicons'.setup() end
  },
}
