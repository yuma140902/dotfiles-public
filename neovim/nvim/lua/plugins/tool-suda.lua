---@type LazySpec
return {
  -- sudoでファイルを読み書きする
  'https://github.com/lambdalisue/suda.vim',
  cond = not vim.g.vscode,
  cmd = { 'SudaRead', 'SudaWrite' },
  init = function()
    vim.g.suda_smart_edit = 1
  end
}
