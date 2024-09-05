local M = {}

function M.config()
  local null_ls = require 'null-ls'
  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.dart_format,
      null_ls.builtins.diagnostics.textlint.with {
        filetypes = { 'text', 'markdown', 'tex' }
      },
      null_ls.builtins.formatting.textlint.with {
        filetypes = { 'text', 'markdown', 'tex' }
      }
    }
  }
end

return M
