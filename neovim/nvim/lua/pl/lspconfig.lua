local M = {}

function M.config()
  require 'lspconfig'.dartls.setup {
    capabilities = require 'cmp_nvim_lsp'.default_capabilities(),
    on_attach = require 'rc.lib'.on_attach
  }
end

return M
