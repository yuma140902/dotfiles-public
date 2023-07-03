-- LSPに関するプラグイン
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
    config = function()
      require 'lsp'.setup_lsp()
    end,
    cmd = 'Mason',
    event = { 'BufNewFile', 'BufRead' }
  },
  { 'williamboman/mason.nvim',           lazy = true },
  { 'williamboman/mason-lspconfig.nvim', lazy = true },
  {
    'j-hui/fidget.nvim', -- LSPの状態を右下に表示する
    tag = 'legacy',      -- TODO:
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'fidget'.setup {
        text = { spinner = 'dots' },
        window = { blend = 0, border = 'none' }
      }
    end,
    event = 'LspAttach'
  },
}
