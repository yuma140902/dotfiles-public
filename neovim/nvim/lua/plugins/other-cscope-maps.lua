---@type LazySpec
return {
  'https://github.com/dhananjaylatkar/cscope_maps.nvim',
  dependencies = {
    'https://github.com/nvim-telescope/telescope.nvim',
  },
  cond = not vim.g.vscode,
  keys = { '<leader>c' },
  cmd = { 'Cs', 'Cstag', 'CsPrompt', 'CsStackView' },

  config = function()
    require 'cscope_maps'.setup {
      disable_maps = false,
      prefix = '<leader>c',

      cscope = {
        picker = 'telescope',
      },
    }
  end
}
