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
    local map = require 'rc.keymaps'.map
    require 'which-key'.add { '<space>R', group = 'Rustaceanvim' }
    map.n '<space>RB' { '<cmd>RustLsp debuggables<CR>', desc = 'DAPでデバッグ' }
    map.n '<space>Rb' { '<cmd>RustLsp debuggables last<CR>', desc = '最後のターゲットをDAPでデバッグ' }
    map.n '<space>Rr' { '<cmd>RustLsp runnables<CR>', desc = '実行' }
    map.n '<space>RR' { '<cmd>RustLsp runnables last<CR>', desc = '最後のターゲットを実行' }
    map.nx '<space>Rm' { '<cmd>RustLsp expandMacro<CR>', desc = 'マクロを再帰的に展開' }
    map.nx '<space>RP' { '<cmd>RustLsp rebuildProcMacros<CR>', desc = 'proc macroを再ビルド' }
    map.nx '<space>R[' { '<cmd>RustLsp moveItem up<CR>', desc = 'アイテムを上に移動' }
    map.nx '<space>R]' { '<cmd>RustLsp moveItem down<CR>', desc = 'アイテムを下に移動' }
    map.nx '<space>RA' { '<cmd>RustLsp hover actions<CR>', desc = 'Hover Actionsを表示' }
    map.nx '<space>Ra' { '<cmd>RustLsp hover range<CR>', desc = 'Hover Rangeを表示' }
    map.n '<space>Rd' { '<cmd>RustLsp explainError<CR>', desc = 'エラーの解説を表示' }
    map.n '<space>RC' { '<cmd>RustLsp openCargo<CR>', desc = 'Cargo.tomlを表示' }
    map.n '<space>Rp' { '<cmd>RustLsp parentModule<CR>', desc = '親モジュール' }
    map.nx '<space>RJ' { '<cmd>RustLsp joinLines<CR>', desc = '行を結合' }
    map.nx '<space>Rs' { '<cmd>RustLsp syntaxTree<CR>', desc = '構文木を表示' }
    map.n '<space>Rc' { '<cmd>RustLsp flyCheck<CR>', desc = 'fly-checkを実行' }
  end
}
