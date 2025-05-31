-- load neodev.nvim
require 'pl.neodev'.config()

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      hint = {
        enable = true
      }
    }
  }
}
