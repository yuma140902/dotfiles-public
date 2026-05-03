---@type LazySpec
return {
  -- 2 つの選択範囲の差分を表示する
  'https://github.com/AndrewRadev/linediff.vim',
  cond = not vim.g.vscode,
  cmd = 'Linediff',
}
