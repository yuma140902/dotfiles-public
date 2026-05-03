---@type LazySpec
return {
  -- quickfix リストを編集できるようにする
  'https://github.com/itchyny/vim-qfedit',
  cond = not vim.g.vscode,
  ft = 'qf',
}
