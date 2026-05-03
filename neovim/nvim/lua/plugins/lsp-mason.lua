---@type LazySpec
return {
  -- LSP 等のインストーラ
  'https://github.com/mason-org/mason.nvim',
  cond = not vim.g.vscode,
  cmd = 'Mason',
  config = function()
    require 'mason'.setup()
  end
}
