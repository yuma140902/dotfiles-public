-- ライブラリ的なプラグイン
return {
  {
    -- 構文解析をしてくれるやつ。それぞれの言語用のパーサーを:TSInstallで別途インストールする必要があるので注意
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          -- TODO: 活用方法がいまいちわからない
          keymaps = {
            init_selection = "tnn", -- set to `false` to disable one of the mings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true
        }
      }
    end,
    cmd = { 'TSUpdate', 'TSEnable' },
    event = { 'BufNewFile', 'BufRead' }
  },
  { 'nvim-lua/plenary.nvim' },     -- Luaの関数集。少なくともtodo-comments.nvimが依存している
  {
    'nvim-tree/nvim-web-devicons', -- deviconに関するライブラリ。trouble.nvim, ddu-column-icon_filenameなどのアイコン表示が改善される
    lazy = true,
    config = function() require 'nvim-web-devicons'.setup() end
  },
}
