---@type LazySpec
return {
  'https://github.com/folke/lazydev.nvim',
  cond = not vim.g.vscode,
  ft = 'lua',
  cmd = 'LazyDev',

  config = function()
    require 'lazydev'.setup {
      integrations = {
        lspconfig = true,
        cmp = true,
      },
    }
  end
}
