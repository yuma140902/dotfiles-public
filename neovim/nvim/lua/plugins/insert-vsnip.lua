---@type LazySpec
return {
  -- スニペットエンジン
  'https://github.com/hrsh7th/vim-vsnip',
  cond = not vim.g.vscode,
  dependencies = {
    -- 他のプラグインとの連携
    { 'https://github.com/hrsh7th/vim-vsnip-integ' },
    -- スニペット集
    { 'https://github.com/rafamadriz/friendly-snippets' },
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
}
