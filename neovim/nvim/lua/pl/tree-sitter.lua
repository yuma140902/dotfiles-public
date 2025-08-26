local M = {}

function M.config()
  require 'nvim-treesitter.configs'.setup {
    sync_install = false,
    auto_install = true,
    ignore_install = { 'org' },
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
end

return M
