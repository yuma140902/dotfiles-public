local M = {}

---@alias rc.IconCat 'LSP'|'Lspsaga'
---@type table<rc.IconCat, wk.Icon>
local IconCatTable = {
  LSP = { icon = '', color = 'purple' },
  Lspsaga = { icon = '', color = 'orange' },
}

---@class mapset_opts: vim.keymap.set.Opts
---@field icon? rc.IconCat|wk.Icon

-- reference: https://zenn.dev/monaqa/articles/2025-07-23-vim-keymap-set-dsl

---@param mode string|string[]
---@param is_buffer_local? boolean
---@return fun(lhs: string): fun(opts: mapset_opts): nil
local function map_(mode, is_buffer_local)
  ---@param lhs string
  ---@return fun(vim.keymap.set.Opts): nil
  return function(lhs)
    ---@param opts mapset_opts
    return function(opts)
      local body = opts[1]
      local icon = opts['icon']
      opts[1] = nil
      opts['icon'] = nil
      if opts['buffer'] == nil then
        opts['buffer'] = is_buffer_local
      end
      if opts['desc'] ~= nil and type(icon) == 'string' then
        opts['desc'] = '[' .. icon .. ']' .. opts['desc']
      end
      if type(icon) == 'string' then
        icon = IconCatTable[icon]
      end
      vim.keymap.set(mode, lhs, body, opts)
      if icon ~= nil then
        require 'which-key'.add {
          mode = mode,
          { lhs, icon = icon }
        }
      end
    end
  end
end

M.map = {
  --- NORMAL mode のキーマップを定義する。
  n = map_ 'n',
  --- VISUAL mode のキーマップを定義する。
  x = map_ 'x',
  --- OPERATOR-PENDING mode のキーマップを定義する。
  o = map_ 'o',
  --- INSERT mode のキーマップを定義する。
  i = map_ 'i',
  --- COMMAND-LINE mode のキーマップを定義する。
  c = map_ 'c',
  --- SELECT mode のキーマップを定義する。
  s = map_ 'x',
  --- TERMINAL mode のキーマップを定義する。
  t = map_ 't',

  --- NORMAL / VISUAL キーマップ（オペレータ/モーションなど）
  nx = map_ { 'n', 'x' },
  --- VISUAL / SELECT キーマップ（制御文字を用いた VISUAL キーマップなど）
  xs = map_ { 'x', 's' },
  --- VISUAL / OPERATOR-PENDING キーマップ（モーション、text object など）
  xo = map_ { 'x', 'o' },
  --- NORMAL / TERMINAL キーマップ（ターミナルの制御など）
  nt = map_ { 'n', 't' },

  --- NORMAL-like mode のキーマップ（モーションなど）
  nxo = map_ { 'n', 'x', 'o' },
  --- INSERT-like mode のキーマップ（文字入力など）
  ic = map_ { 'i', 'c' },

  --- iabbrev を定義する。
  ia = map_ 'ia',
  --- cabbrev を定義する。
  ca = map_ 'ca',

  --- モードを文字列で指定してキーマップを定義する。
  with_mode = map_,
}
local map = M.map

M.map_local = {
  --- NORMAL mode の buffer-local キーマップを定義する。
  n = map_('n', true),
  --- VISUAL mode の buffer-local キーマップを定義する。
  x = map_('x', true),
  --- OPERATOR-PENDING mode の buffer-local キーマップを定義する。
  o = map_('o', true),
  --- INSERT mode の buffer-local キーマップを定義する。
  i = map_('i', true),
  --- COMMAND-LINE mode の buffer-local キーマップを定義する。
  c = map_('c', true),
  --- SELECT mode の buffer-local キーマップを定義する。
  s = map_('s', true),
  --- TERMINAL mode の buffer-local キーマップを定義する。
  t = map_('t', true),

  --- NORMAL / VISUAL の buffer-local キーマップ。
  nx = map_({ 'n', 'x' }, true),
  --- VISUAL / SELECT の buffer-local キーマップ。
  xs = map_({ 'x', 's' }, true),
  --- VISUAL / OPERATOR-PENDING の buffer-local キーマップ。
  xo = map_({ 'x', 'o' }, true),

  --- NORMAL-like モードの buffer-local キーマップ。
  nxo = map_({ 'n', 'x', 'o' }, true),
  --- INSERT-like モードの buffer-local キーマップ。
  ic = map_({ 'i', 'c' }, true),

  --- buffer-local iabbrev を定義する。
  ia = map_('ia', true),
  --- buffer-local cabbrev を定義する。
  ca = map_('ca', true),
}

function M.register_keymaps()
  require 'which-key'.add { '<space>t', group = 'ターミナル' }

  map.n '[b' { '<Cmd>bprev<CR>', desc = '前のバッファ' }
  map.n ']b' { '<Cmd>bnext<CR>', desc = '次のバッファ' }
  map.n '<C-h>' { '<Cmd>tabprev<CR>', desc = '前のタブ' }
  map.n '<C-l>' { '<Cmd>tabnext<CR>', desc = '次のタブ' }
  map.nx 'gy' { '"+y', desc = 'システムのクリップボードにヤンク' }
  map.n 'gY' { 'gg"+yG', desc = 'バッファ全体をシステムのクリップボードにヤンク' }

  -- インサートモード
  map.i '<C-l>' {
    desc = '直前の単語を大文字にする',
    function()
      -- [Vim でアルファベット大文字の単語を楽に打つ裏技](https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase)
      local line = vim.fn.getline('.')
      local col = vim.fn.getpos('.')[3]
      local substring = line:sub(1, col - 1)
      local result = vim.fn.matchstr(substring, '[a-zA-Z0-9_]*$')
      return '<C-w>' .. result:upper()
    end,
    expr = true,
  }

  -- ターミナル
  map.n '<Space>te' { '<Cmd>terminal<CR>', desc = 'ターミナルを開く' }
  map.n '<Space>tt' { '<Cmd>tabnew<CR><Cmd>terminal<CR>', desc = 'ターミナルを新規タブで開く' }
  map.n '<Space>tj' { '<Cmd>belowright new<CR><cmd>terminal<CR>', desc = 'ターミナルを下に開く' }
  map.n '<Space>tl' { '<C-w>v<C-w>l<Cmd>terminal<CR>', desc = 'ターミナルを左に開く' }

  map.t '<C-h>' { '<Cmd>tabprev<CR>' }
  map.t '<C-l>' { '<Cmd>tabnext<CR>' }

  map.t '<C-\\>' { '<C-\\><C-n>', desc = 'ターミナルノーマルモード' }
  map.t '<C-w>n' { '<Cmd>new<CR>', desc = '新しいウィンドウを開く' }
  map.t '<C-w><C-n>' { '<Cmd>new<CR>' }
  map.t '<C-w>q' { '<Cmd>quit<CR>' }
  map.t '<C-w><C-q>' { '<Cmd>quit<CR>' }
  map.t '<C-w>c' { '<Cmd>close<CR>' }
  map.t '<C-w>o' { '<Cmd>only<CR>' }
  map.t '<C-w><C-o>' { '<Cmd>only<CR>' }
  map.t '<C-w><Down>' { '<Cmd>wincmd j<CR>' }
  map.t '<C-w><C-j>' { '<Cmd>wincmd j<CR>' }
  map.t '<C-w>j' { '<Cmd>wincmd j<CR>' }
  map.t '<C-w><Up>' { '<Cmd>wincmd k<CR>' }
  map.t '<C-w><C-k>' { '<Cmd>wincmd k<CR>' }
  map.t '<C-w>k' { '<Cmd>wincmd k<CR>' }
  map.t '<C-w><Left>' { '<Cmd>wincmd h<CR>' }
  map.t '<C-w><C-h>' { '<Cmd>wincmd h<CR>' }
  map.t '<C-w><BS>' { '<Cmd>wincmd h<CR>' }
  map.t '<C-w>h' { '<Cmd>wincmd h<CR>' }
  map.t '<C-w><Right>' { '<Cmd>wincmd l<CR>' }
  map.t '<C-w><C-l>' { '<Cmd>wincmd l<CR>' }
  map.t '<C-w>l' { '<Cmd>wincmd l<CR>' }
  map.t '<C-w>w' { '<Cmd>wincmd w<CR>' }
  -- map.t '<C-w><C-w>' { '<Cmd>wincmd w<CR>' }
  map.t '<C-w>W' { '<Cmd>wincmd W<CR>' }
  map.t '<C-w>t' { '<Cmd>wincmd t<CR>' }
  map.t '<C-w><C-t>' { '<Cmd>wincmd t<CR>' }
  map.t '<C-w>b' { '<Cmd>wincmd b<CR>' }
  map.t '<C-w><C-b>' { '<Cmd>wincmd b<CR>' }
  map.t '<C-w>p' { '<Cmd>wincmd p<CR>' }
  map.t '<C-w><C-p>' { '<Cmd>wincmd p<CR>' }
  map.t '<C-w>P' { '<Cmd>wincmd P<CR>' }
  map.t '<C-w>r' { '<Cmd>wincmd r<CR>' }
  map.t '<C-w><C-r>' { '<Cmd>wincmd r<CR>' }
  map.t '<C-w>R' { '<Cmd>wincmd R<CR>' }
  map.t '<C-w>x' { '<Cmd>wincmd x<CR>' }
  map.t '<C-w><C-x>' { '<Cmd>wincmd x<CR>' }
  map.t '<C-w>K' { '<Cmd>wincmd K<CR>' }
  map.t '<C-w>J' { '<Cmd>wincmd J<CR>' }
  map.t '<C-w>H' { '<Cmd>wincmd H<CR>' }
  map.t '<C-w>L' { '<Cmd>wincmd L<CR>' }
  map.t '<C-w>T' { '<Cmd>wincmd T<CR>' }
  map.t '<C-w>=' { '<Cmd>wincmd =<CR>' }
  map.t '<C-w>-' { '<Cmd>wincmd -<CR>' }
  map.t '<C-w>+' { '<Cmd>wincmd +<CR>' }
  map.t '<C-w>z' { '<Cmd>pclose<CR>' }
  map.t '<C-w><C-z>' { '<Cmd>pclose<CR>' }

  -- treesitter incremental selection
  map.n '<CR>' {
    function()
      if vim.tbl_contains({ 'vim' }, vim.bo.filetype) then
        return '<CR>'
      end
      return '<Cmd>normal van<CR>'
    end,
    expr = true,
  }
  map.x '<CR>' { function()
    vim.api.nvim_feedkeys('an', 'v', false)
  end
  }
  map.n '<BS>' { '<Cmd>normal vin<CR>' }
  map.x '<BS>' { function()
    vim.api.nvim_feedkeys('in', 'v', false)
  end
  }

  -- vim.diagnostic
  map.n '<space>d' {
    function()
      vim.diagnostic.open_float()
    end
  }
  map.n '[d' {
    desc = '前の診断へ',
    function()
      vim.diagnostic.jump { count = -1, float = false }
    end
  }
  map.n ']d' {
    desc = '次の診断へ',
    function()
      vim.diagnostic.jump { count = 1, float = false }
    end
  }

  -- LSP
  -- その他のマッピングは lspsaga と rustaceanvim の設定を参照
  map.n 'grh' {
    desc = 'Inlay hint をトグル',
    icon = 'LSP',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  }
end

return M
