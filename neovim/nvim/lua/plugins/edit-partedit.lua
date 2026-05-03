---@type LazySpec
return {
  -- バッファの一部を新しいバッファに切り出して編集できる
  -- markdownのコードブロック、Rustのdoctestなどに使える
  'https://github.com/thinca/vim-partedit',
  cond = not vim.g.vscode,
  cmd = 'Partedit',
  config = function()
    vim.g['partedit#opener'] = ':tabe'
  end
}
