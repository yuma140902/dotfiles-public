---@type LazySpec
return {
  'https://github.com/ray-x/lsp_signature.nvim',
  event = 'InsertEnter',
  cond = not vim.g.vscode,
  config = function()
    require 'lsp_signature'.setup {
      bind = true,
      handler_opts = {
        border = 'none'
      },
      hint_prefix = {
        above = '↙ ', -- when the hint is on the line above the current line
        current = '← ', -- when the hint is on the same line
        below = '↖ ' -- when the hint is on the line below the current line
      }
    }
  end
}
