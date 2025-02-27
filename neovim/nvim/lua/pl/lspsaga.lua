local M = {}

function M.config()
  require 'lspsaga'.setup {
    ui = {
      -- :h nvim_open_win
      border = 'rounded',
      devicon = true,
      title = true,
      button = { '', '' },
      code_action = '󰌵',
      actionfix = '',
      imp_sign = '󰳛'
    },
    code_action = {
      num_shortcut = true,
      show_server_name = false,
      extend_gitsigns = true,
    },
    definition = {
      -- peek definitionの幅
      width = 1.0,
    },
    lightbulb = {
      enable = true,
      sign = false,
      virtual_text = true,
    },
    symbol_in_winbar = {
      enable = true
    },
    finder = {
      keys = {
        shuttle = '<Tab>',
        toggle_or_open = '<CR>',
        quit = '<ESC>',
      },
    },
    rename = {
      enable = true,
      in_select = false,
      keys = {
        quit = '<ESC>',
        exec = '<CR>',
        select = 'x'
      }
    },
  }
end

return M
