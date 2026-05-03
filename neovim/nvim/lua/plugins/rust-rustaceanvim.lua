---@type LazySpec
return {
  -- Rustに関する機能を追加する
  'https://github.com/mrcjkb/rustaceanvim',
  cond = not vim.g.vscode,
  ft = 'rust',

  init = function()
    vim.g.rustaceanvim = {}
  end,

  config = function()
    local map_local = require 'rc.keymaps'.map_local
    require 'which-key'.add { '<space>R', group = 'Rustaceanvim' }
    map_local.n '<space>RB' { '<cmd>RustLsp debuggables<CR>', desc = 'DAPでデバッグ' }
    map_local.n '<space>Rb' { '<cmd>RustLsp debuggables last<CR>', desc = '最後のターゲットをDAPでデバッグ' }
    map_local.n '<space>Rr' { '<cmd>RustLsp runnables<CR>', desc = '実行' }
    map_local.n '<space>RR' { '<cmd>RustLsp runnables last<CR>', desc = '最後のターゲットを実行' }
    map_local.nx '<space>Rm' { '<cmd>RustLsp expandMacro<CR>', desc = 'マクロを再帰的に展開' }
    map_local.nx '<space>RP' { '<cmd>RustLsp rebuildProcMacros<CR>', desc = 'proc macroを再ビルド' }
    map_local.nx '<space>R[' { '<cmd>RustLsp moveItem up<CR>', desc = 'アイテムを上に移動' }
    map_local.nx '<space>R]' { '<cmd>RustLsp moveItem down<CR>', desc = 'アイテムを下に移動' }
    map_local.nx '<space>RA' { '<cmd>RustLsp hover actions<CR>', desc = 'Hover Actionsを表示' }
    map_local.nx '<space>Ra' { '<cmd>RustLsp hover range<CR>', desc = 'Hover Rangeを表示' }
    map_local.n '<space>Rd' { '<cmd>RustLsp explainError<CR>', desc = 'エラーの解説を表示' }
    map_local.n '<space>RC' { '<cmd>RustLsp openCargo<CR>', desc = 'Cargo.tomlを表示' }
    map_local.n '<space>Rp' { '<cmd>RustLsp parentModule<CR>', desc = '親モジュール' }
    map_local.nx '<space>RJ' { '<cmd>RustLsp joinLines<CR>', desc = '行を結合' }
    map_local.nx '<space>Rs' { '<cmd>RustLsp syntaxTree<CR>', desc = '構文木を表示' }
    map_local.n '<space>Rc' { '<cmd>RustLsp flyCheck<CR>', desc = 'fly-checkを実行' }
  end
}
