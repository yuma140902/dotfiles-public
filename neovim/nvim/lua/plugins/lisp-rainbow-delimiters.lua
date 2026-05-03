---@type LazySpec
return {
  -- 対応するカッコをネストの深さに応じて色分けする
  'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
  cond = not vim.g.vscode,
  -- Lisp 系のときだけ使用する
  ft = { 'lisp', 'clojure' },
}
