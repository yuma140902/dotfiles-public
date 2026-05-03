---@type LazySpec
return {
  -- schemastore.org が提供している JSON の様々なスキーマを読み込む
  'https://github.com/b0o/schemastore.nvim',
  cond = not vim.g.vscode,
  -- mason-lspconfig が jsonls の設定をするときに読み込まれる
  lazy = true,
}
