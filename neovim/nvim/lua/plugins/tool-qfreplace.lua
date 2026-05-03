---@type LazySpec
return {
  -- quickfix リストから置換バッファを作り、置換バッファを編集すると実際のファイルに反映される
  'https://github.com/thinca/vim-qfreplace',
  cond = not vim.g.vscode,
  cmd = { 'Qfreplace' },
}
