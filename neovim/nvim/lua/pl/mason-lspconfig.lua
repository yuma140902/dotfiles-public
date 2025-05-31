local M = {}

function M.config()
  require 'mason-lspconfig'.setup {
    automatic_enable = {
      -- rust-analyzerのセットアップはmason-lspconfigではなくrustaceanvimが行う
      exclude = { "rust_analyzer" }
    },
  }
end

return M
