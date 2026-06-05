---@type vim.lsp.Config
return {
  root_markers = {
    'package.json',
  },
  workspace_required = true,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'none', -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'none', -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  }
}
