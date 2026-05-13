---@type LazySpec
return {
  -- LSP用のUI
  'https://github.com/nvimdev/lspsaga.nvim',
  cond = not vim.g.vscode,
  dependencies = {
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-treesitter/nvim-treesitter',
  },
  event = 'LspAttach',
  config = function()
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
        num_shortcut = false,
        show_server_name = true,
        extend_gitsigns = true,
        keys = {
          quit = '<ESC>',
          exec = '<CR>',
        },
      },
      definition = {
        -- peek definition の幅
        width = 1.0,
      },
      lightbulb = {
        enable = true,
        sign = false,
        virtual_text = true,
      },
      symbol_in_winbar = {
        enable = false,
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
        },
      },
    }

    local map = require 'rc.keymaps'.map
    map.n 'gD' { '<Cmd>Lspsaga goto_type_definition<CR>', desc = '型を表示', icon = 'Lspsaga' }
    map.n 'gd' { '<Cmd>Lspsaga goto_definition<CR>', desc = '定義を表示', icon = 'Lspsaga' }
    map.n 'gi' { '<Cmd>Lspsaga finder imp<CR>', desc = '実装を表示', icon = 'Lspsaga' }
    map.n '<space>D' { vim.lsp.buf.type_definition, desc = '型定義を表示', icon = 'LSP' }

    map.n 'grr' { '<Cmd>Lspsaga finder ref<CR>', desc = '参照を表示', icon = 'Lspsaga' }
    map.n 'gri' { '<Cmd>Lspsaga finder imp <CR>', desc = '実装を表示', icon = 'Lspsaga' }
    map.n 'gra' { '<Cmd>Lspsaga code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }
    map.n 'grn' { '<Cmd>Lspsaga rename<CR>', desc = 'リネームする', icon = 'Lspsaga' }
    map.n 'grI' { '<Cmd>Lspsaga incoming_calls<CR>', desc = 'incoming callsを表示', icon = 'Lspsaga' }
    map.n 'grO' { '<Cmd>Lspsaga outgoing_calls<CR>', desc = 'outgoing callsを表示', icon = 'Lspsaga' }
    map.n 'K' { '<Cmd>Lspsaga hover_doc<CR>', desc = 'ドキュメント表示', icon = 'Lspsaga' }
    map.n '<space>r' { '<Cmd>Lspsaga rename<CR>', desc = 'リネームする', icon = 'Lspsaga' }
    map.nx '<space>a' { '<Cmd>Lspsaga code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }
  end
}
