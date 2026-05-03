---@type LazySpec
return {
  -- GitHub Copilot
  'https://github.com/zbirenbaum/copilot.lua',
  cond = not vim.g.vscode,
  config = function()
    require 'copilot'.setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        tex = false,
        plaintex = false,
        typst = false,
      },
      nes = {
        enabled = false,
      },
    }
  end,
  cmd = { 'Copilot' },
  event = { 'InsertEnter' },
}
