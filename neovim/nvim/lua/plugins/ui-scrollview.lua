---@type LazySpec
return {
  -- スクロールバーを表示する
  'https://github.com/dstein64/nvim-scrollview',
  cond = not vim.g.vscode,
  event = { 'User UIEnterPost' },
  config = function()
    require 'scrollview'.setup {
      excluded_filetypes = {},
      winblend = 0,
    }
  end
}
