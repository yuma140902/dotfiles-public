---@type LazySpec
return {
  -- Language Server の状態を右下に表示する
  'https://github.com/j-hui/fidget.nvim',
  dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
  cond = not vim.g.vscode,
  event = 'LspAttach',
  config = function()
    require 'fidget'.setup {
      progress = {
        ignore_done_already = true,
        ignore_empty_message = true,
        --ignore = { 'null-ls' },
        display = {
          progress_icon =
          { pattern = 'dots', period = 1 },
        }
      },
      notification = {
        window = {
          border = 'none',
          relative = 'editor'
        }
      },
    }
  end
}
