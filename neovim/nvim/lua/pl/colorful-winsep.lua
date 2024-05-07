local M = {}

function M.config()
  require 'colorful-winsep'.setup {
    smooth = false,
    exponential_smoothing = false,
    --symbols = { '─', '│', '┌', '┐', '└', '┘' },
    symbols = { '─', '│', '╭', '╮', '╰', '╯' },
  }
end

return M
