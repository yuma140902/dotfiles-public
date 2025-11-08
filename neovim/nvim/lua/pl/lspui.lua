local M = {}

function M.config()
  require 'LspUI'.setup {
    rename = {
      enable = true,
      command_enable = true,
      auto_select = false,
      key_binding = {
        quit = '<ESC>',
        exec = '<CR>',
      },
    },
    lightbulb = {
      enable = true,
      is_cached = true,
      sign = false,
      code_action = '󰌵',
      debounce = 250,
    },
    code_action = {
      enable = true,
      command_enable = true,
      gitsigns = false,
      -- TODO: lspsaga の show_server_name = true,
      key_binding = {
        quit = '<ESC>',
        exec = '<CR>',
        prev = 'k',
        next = 'j',
      },
    },
    diagnostic = {
      enable = true,
      command_enable = true,
    },
    hover = {
      enable = true,
      command_enable = true,
      key_binding = {
        quit = '<ESC>',
      },
    },
    inlay_hint = {
      -- neovim の組み込み機能を使うので無効化
      enable = false,
      command_enable = true,
    },
    definition = {
      enable = true,
      command_enable = true,
    },
    type_definition = {
      enable = true,
      command_enable = true,
    },
    declaration = {
      enable = true,
      command_enable = true,
    },
    implementation = {
      enable = true,
      command_enable = true,
    },
    references = {
      enable = true,
      command_enable = true,
    },
    pos_keybind = {
      main = {
        back = '<NOP>',
        hide_secondary = '<NOP>',
      },
      secondary = {
        jump = '<CR>',
        jump_split = 'sh',
        jump_vsplit = 'sv',
        jump_tab = 't',
        toggle_fold = '<space>',
        next_entry = 'J',
        prev_entry = 'K',
        quit = '<ESC>',
        hide_main = '<NOP>',
        fold_all = 'w',
        expand_all = 'e',
        enter = '<NOP>',
      },
    },
    signature = {
      -- "ray-x/lsp_signature.nvim" を使うので無効化
      enable = false,
    },
  }
end

return M
