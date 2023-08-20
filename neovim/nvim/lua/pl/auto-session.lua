local M = {}

function M.config()
  require 'auto-session'.setup {
    log_level = 'error',     -- デフォルトはinfo。うるさかったらerrorにすればよい
    auto_save_enabled = not vim.g.neovide,
    auto_restore_enabled = not vim.g.neovide,
  }
end

return M
