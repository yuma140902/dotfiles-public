local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.offsetEncoding = "utf-8"
capabilities.offset_encoding = "utf-8"
capabilities.clang = {}
capabilities.clang.offsetEncoding = "utf-8"
capabilities.clang.offset_encoding = "utf-8"

---@type vim.lsp.Config
return {
  capabilities = capabilities,
}
