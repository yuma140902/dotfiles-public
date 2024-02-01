local M = {}

function M.config()
  require 'lspsaga'.setup {
    ui = {
      -- :h nvim_open_win
      border = 'single',
      devicon = true,
      title = true,
      code_action = '󰌵',
      actionfix = '',
      imp_sign = '󰳛'
    },
    code_action = {
      extend_gitsigns = true
    },
    lightbulb = {
      enable = true,
      sign = false,
      virtual_text = true,
    },
    symbol_in_winbar = {
      enable = false
    },
    rename = {
      enable = true,
      keys = {
        quit = '<ESC>',
        exec = '<CR>',
        select = 'x'
      }
    },
  }
end

return M
