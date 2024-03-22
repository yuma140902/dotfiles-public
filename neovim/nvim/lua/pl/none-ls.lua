local M = {}

function M.config()
  local null_ls = require 'null-ls'
  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.clang_format
    }
  }
end

return M
