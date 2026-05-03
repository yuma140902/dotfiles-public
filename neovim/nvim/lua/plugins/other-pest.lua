---@type LazySpec
return {
  -- pest-parser の syntax highlight
  'https://github.com/pest-parser/pest.vim',
  cond = not vim.g.vscode,
  ft = 'pest',
}
