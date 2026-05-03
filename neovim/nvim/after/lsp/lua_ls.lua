---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
      },
      hint = {
        enable = true,
      },
    }
  }
}
