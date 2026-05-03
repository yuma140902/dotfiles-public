---@type LazySpec
return {
  -- Language server のデフォルト設定の提供
  'https://github.com/neovim/nvim-lspconfig',
  cond = not vim.g.vscode,
}
