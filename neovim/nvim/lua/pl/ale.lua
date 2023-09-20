local M = {}

function M.config()
  vim.g.ale_lint_on_text_changed = 0
  vim.g.ale_lint_on_save = 1
  vim.g.ale_fix_on_save = 1
  vim.g.ale_fixers = {
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    css = { 'prettier' },
  }
  vim.g.ale_javascript_prettier_options = '--single-quote --trailing-comma all'
end

return M
