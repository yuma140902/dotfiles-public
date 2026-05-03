---@type LazySpec
return {
  'https://github.com/shellRaining/hlchunk.nvim',
  cond = not vim.g.vscode,
  event = { 'User UIEnterPost' },
  cmd = 'EnableHL',

  config = function()
    require 'hlchunk'.setup {
      chunk = {
        enable = true,
        notify = false,
        use_treesitter = true,
        delay = 0,
      },
      indent = {
        enable = false,
      },
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      }
    }
  end
}
