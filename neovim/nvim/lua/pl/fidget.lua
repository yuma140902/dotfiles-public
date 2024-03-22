local M = {}

function M.config()
  require 'fidget'.setup {
    progress = {
      ignore_done_already = true,
      ignore_empty_message = true,
      --ignore = { 'null-ls' },
      display = {
        progress_icon =
        { pattern = "dots", period = 1 },
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

return M
