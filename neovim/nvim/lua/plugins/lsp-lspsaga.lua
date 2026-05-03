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

    local map_local = require 'rc.keymaps'.map_local
    map_local.n 'gD' { '<Cmd>Lspsaga goto_type_definition<CR>', desc = '型を表示', icon = 'Lspsaga' }
    map_local.n 'gd' { '<Cmd>Lspsaga goto_definition<CR>', desc = '定義を表示', icon = 'Lspsaga' }
    map_local.n 'gi' { '<Cmd>Lspsaga finder imp<CR>', desc = '実装を表示', icon = 'Lspsaga' }
    map_local.n '<space>D' { vim.lsp.buf.type_definition, desc = '型定義を表示', icon = 'LSP' }

    map_local.n 'grr' { '<Cmd>Lspsaga finder ref<CR>', desc = '参照を表示', icon = 'Lspsaga' }
    map_local.n 'gri' { '<Cmd>Lspsaga finder imp <CR>', desc = '実装を表示', icon = 'Lspsaga' }
    map_local.n 'gra' { '<Cmd>Lspsaga code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }
    map_local.n 'grn' { '<Cmd>Lspsaga rename<CR>', desc = 'リネームする', icon = 'Lspsaga' }
    map_local.n 'grI' { '<Cmd>Lspsaga incoming_calls<CR>', desc = 'incoming callsを表示', icon = 'Lspsaga' }
    map_local.n 'grO' { '<Cmd>Lspsaga outgoing_calls<CR>', desc = 'outgoing callsを表示', icon = 'Lspsaga' }
    map_local.n 'K' { '<Cmd>Lspsaga hover_doc<CR>', desc = 'ドキュメント表示', icon = 'Lspsaga' }
    map_local.n '<space>r' { '<Cmd>Lspsaga rename<CR>', desc = 'リネームする', icon = 'Lspsaga' }
    map_local.nx '<space>a' { '<Cmd>Lspsaga code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }
  end
}
