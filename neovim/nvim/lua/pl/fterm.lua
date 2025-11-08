local M = {}

function M.config()
  if vim.fn.has('win32') == 1 then
    if vim.fn.executable('pwsh') == 1 then
      cmd = 'pwsh'
    else
      cmd = 'powershell'
    end
  else
    cmd = os.getenv('SHELL')
  end
  require 'FTerm'.setup {
    border = 'rounded',
    dimensions = {
      height = 0.9,
      width = 0.9,
    },
    cmd = cmd,
  }
end

return M
