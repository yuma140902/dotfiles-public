---@type LazySpec
return {
  -- mason でインストールしたサーバーのセットアップを行う
  'https://github.com/mason-org/mason-lspconfig.nvim',
  cond = not vim.g.vscode,
  dependencies = {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre', 'FilterReadPre', 'FileReadPre' },
  config = function()
    require 'mason-lspconfig'.setup {
      automatic_enable = {
        -- rust-analyzer のセットアップは mason-lspconfig ではなく rustaceanvim が行う
        exclude = { 'rust_analyzer' }
      },
    }
  end
}
