local map = require 'rc.lib'.map

local function register_keymaps()
  require 'which-key'.add {
    { '<space>l', group = 'trouble.nvim' },
    { '<space>h', group = 'gitsigns' },
    { '<space>ht', group = 'トグル' },
    { '<space>g', group = 'fugitive' },
    { '<space>f', group = 'Telescope' },
    { '<space>fg', group = 'Git 関係' },
    { '<space>fgh', group = 'GitHub 関係' },
    { '<space>fx', group = 'その他' },
    { '<space>c', group = 'crates.nvim' },
    { '<space>R', group = 'Rustaceanvim' },
    { '<space>b', group = 'デバッグ' },
    { '<space>t', group = 'ターミナル' },
    { '<space>j', group = 'Join/Split' },
  }

  -- ノーマルモード
  map.n '[b' { '<cmd>bprev<CR>', desc = '前のバッファ' }
  map.n ']b' { '<cmd>bnext<CR>', desc = '次のバッファ' }
  map.nx 'gx' {
    desc = '標準アプリで開く',
    function()
      local cfile = vim.fn.expand('<cfile>')
      local pat = vim.regex("^[[:alnum:]_.-]\\+/[[:alnum:]_.-]\\+$")
      if pat ~= nil and pat:match_str(cfile) then
        vim.ui.open("https://github.com/" .. cfile)
      else
        vim.ui.open(cfile)
      end
    end,
  }
  map.n '<C-h>' { '<cmd>tabprev<CR>' }
  map.n '<C-l>' { '<cmd>tabnext<CR>' }

  -- インサートモード
  map.i '<C-l>' {
    desc = '直前の単語を大文字にする',
    function()
      -- [Vim でアルファベット大文字の単語を楽に打つ裏技](https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase)
      local line = vim.fn.getline(".")
      local col = vim.fn.getpos(".")[3]
      local substring = line:sub(1, col - 1)
      local result = vim.fn.matchstr(substring, "[a-zA-Z0-9_]*$")
      return "<C-w>" .. result:upper()
    end,
    expr = true,
  }

  -- ターミナル
  map.n '<space>tn' { '<cmd>terminal<CR>', desc = 'ターミナルを開く' }
  map.n '<space>tt' { '<cmd>tabnew<CR><cmd>terminal<CR><cmd>startinsert<CR>', desc = 'ターミナルを新規タブで開く' }
  map.n '<space>tf' { '<cmd>Lspsaga term_toggle<CR>', desc = 'floating windowのターミナルをトグル' }
  map.nt '<A-d>' { '<cmd>Lspsaga term_toggle<CR>', desc = 'floating windowのターミナルをトグル' }
  map.n '<space>tj' { '<cmd>belowright new<CR><cmd>terminal<CR><cmd>startinsert<CR>', desc = 'ターミナルを下に開く' }
  map.n '<space>tl' { '<C-w>v<C-w>l<cmd>terminal<CR><cmd>startinsert<CR>', desc = 'ターミナルを左に開く' }

  map.t '<C-h>' { '<cmd>tabprev<CR>' }
  map.t '<C-l>' { '<cmd>tabnext<CR>' }

  map.t '<C-\\>' { '<C-\\><C-n>', desc = 'ターミナルノーマルモード' }
  map.t '<C-w>n' { '<cmd>new<CR>', desc = '新しいウィンドウを開く' }
  map.t '<C-w><C-n>' { '<cmd>new<CR>' }
  map.t '<C-w>q' { '<cmd>quit<CR>' }
  map.t '<C-w><C-q>' { '<cmd>quit<CR>' }
  map.t '<C-w>c' { '<cmd>close<CR>' }
  map.t '<C-w>o' { '<cmd>only<CR>' }
  map.t '<C-w><C-o>' { '<cmd>only<CR>' }
  map.t '<C-w><Down>' { '<cmd>wincmd j<CR>' }
  map.t '<C-w><C-j>' { '<cmd>wincmd j<CR>' }
  map.t '<C-w>j' { '<cmd>wincmd j<CR>' }
  map.t '<C-w><Up>' { '<cmd>wincmd k<CR>' }
  map.t '<C-w><C-k>' { '<cmd>wincmd k<CR>' }
  map.t '<C-w>k' { '<cmd>wincmd k<CR>' }
  map.t '<C-w><Left>' { '<cmd>wincmd h<CR>' }
  map.t '<C-w><C-h>' { '<cmd>wincmd h<CR>' }
  map.t '<C-w><BS>' { '<cmd>wincmd h<CR>' }
  map.t '<C-w>h' { '<cmd>wincmd h<CR>' }
  map.t '<C-w><Right>' { '<cmd>wincmd l<CR>' }
  map.t '<C-w><C-l>' { '<cmd>wincmd l<CR>' }
  map.t '<C-w>l' { '<cmd>wincmd l<CR>' }
  map.t '<C-w>w' { '<cmd>wincmd w<CR>' }
  --map.t '<C-w><C-w>' { '<cmd>wincmd w<CR>' }
  map.t '<C-w>W' { '<cmd>wincmd W<CR>' }
  map.t '<C-w>t' { '<cmd>wincmd t<CR>' }
  map.t '<C-w><C-t>' { '<cmd>wincmd t<CR>' }
  map.t '<C-w>b' { '<cmd>wincmd b<CR>' }
  map.t '<C-w><C-b>' { '<cmd>wincmd b<CR>' }
  map.t '<C-w>p' { '<cmd>wincmd p<CR>' }
  map.t '<C-w><C-p>' { '<cmd>wincmd p<CR>' }
  map.t '<C-w>P' { '<cmd>wincmd P<CR>' }
  map.t '<C-w>r' { '<cmd>wincmd r<CR>' }
  map.t '<C-w><C-r>' { '<cmd>wincmd r<CR>' }
  map.t '<C-w>R' { '<cmd>wincmd R<CR>' }
  map.t '<C-w>x' { '<cmd>wincmd x<CR>' }
  map.t '<C-w><C-x>' { '<cmd>wincmd x<CR>' }
  map.t '<C-w>K' { '<cmd>wincmd K<CR>' }
  map.t '<C-w>J' { '<cmd>wincmd J<CR>' }
  map.t '<C-w>H' { '<cmd>wincmd H<CR>' }
  map.t '<C-w>L' { '<cmd>wincmd L<CR>' }
  map.t '<C-w>T' { '<cmd>wincmd T<CR>' }
  map.t '<C-w>=' { '<cmd>wincmd =<CR>' }
  map.t '<C-w>-' { '<cmd>wincmd -<CR>' }
  map.t '<C-w>+' { '<cmd>wincmd +<CR>' }
  map.t '<C-w>z' { '<cmd>pclose<CR>' }
  map.t '<C-w><C-z>' { '<cmd>pclose<CR>' }

  -- LSP関係
  map.n 'gD' { '<cmd>Lspsaga goto_type_definition<CR>', desc = '型の定義へ移動', icon = 'Lspsaga' }
  map.n 'gd' { '<cmd>Lspsaga goto_definition<CR>', desc = '定義へ移動', icon = 'Lspsaga' }
  map.n 'gi' { '<cmd>Lspsaga finder imp<CR>', desc = '実装へ移動', icon = 'Lspsaga' }
  map.n 'gp' { '<cmd>Lspsaga peek_definition<CR>', desc = '定義を表示', icon = 'Lspsaga' }
  map.n 'gP' { '<cmd>Lspsaga peek_type_definition<CR>', desc = '型定義を表示', icon = 'Lspsaga' }
  map.n '<space>D' { vim.lsp.buf.type_definition, desc = '変数の型の定義へ移動', icon = 'LSP' }

  map.n 'grr' { '<cmd>Lspsaga finder ref+def<CR>', desc = '参照・定義へ移動', icon = 'Lspsaga' }
  map.n 'gri' { '<cmd>Lspsaga finder imp<CR>', desc = '実装へ移動', icon = 'Lspsaga' }
  map.n 'gra' { '<cmd>Lspsaga code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }
  map.n 'grn' { '<cmd>Lspsaga rename<CR>', desc = 'リネームする', icon = 'Lspsaga' }
  map.n 'grI' { '<cmd>Lspsaga incoming_calls<CR>', desc = 'incoming callsを表示', icon = 'Lspsaga' }
  map.n 'grO' { '<cmd>Lspsaga outgoing_calls<CR>', desc = 'outgoing callsを表示', icon = 'Lspsaga' }
  map.n 'grh' {
    desc = 'Inlay hint をトグル',
    icon = 'LSP',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  }
  map.n 'K' { '<cmd>Lspsaga hover_doc<CR>', desc = 'ドキュメント表示', icon = 'Lspsaga' }
  map.n '<space>r' { '<cmd>Lspsaga rename<CR>', desc = 'リネームする', icon = 'Lspsaga' }
  map.n '<space>a' { '<cmd>Lspsaga code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }
  map.x '<space>a' { '<cmd>Lspsaga range_code_action<CR>', desc = 'コードアクションを表示', icon = 'Lspsaga' }

  -- 診断関係
  -- :h vim.diagnostic.*
  map.n '<space>d' { '<cmd>Lspsaga show_line_diagnostics<CR>', desc = '診断(エラーメッセージ等)をフロート表示', icon = 'Lspsaga' }
  map.n '[d' { '<cmd>Lspsaga diagnostic_jump_prev<CR>', desc = '前の診断へ', icon = 'Lspsaga' }
  map.n ']d' { '<cmd>Lspsaga diagnostic_jump_next<CR>', desc = '次の診断へ', icon = 'Lspsaga' }

  -- trouble.nvim
  map.n '<space>lw' { '<cmd>Trouble diagnostics toggle<CR>', desc = 'プロジェクト全体の診断情報' }
  map.n '<space>ll' { '<cmd>Trouble loclist toggle<CR>', desc = 'loclist' }
  map.n '<space>lq' { '<cmd>Trouble quickfix toggle<CR>', desc = 'QuickFix' }

  -- todo-comments.nvim
  map.n '<space>lt' { '<cmd>Trouble todo toggle<CR>', desc = 'TODOコメント' }
  map.n '<space>ft' { '<cmd>TodoTelescope<CR>', desc = 'TODOコメント' }
  map.n ']t' { function() require 'todo-comments'.jump_next() end, desc = '次のTODOコメントへ' }
  map.n '[t' { function() require 'todo-comments'.jump_prev() end, desc = '前のTODOコメントへ' }

  -- aerial
  map.n '<space><space>' { '<cmd>AerialToggle float<CR>', desc = 'Aerialを開く' }
  map.n '<right>' { '<cmd>AerialToggle! right<CR>', desc = 'Aerialを開閉' }
  map.n ']]' { '<cmd>AerialNext<CR>', desc = 'AerialNext' }
  map.n '[[' { '<cmd>AerialPrev<CR>', desc = 'AerialPrev' }

  map.n '[c' { function() require("treesitter-context").go_to_context() end, desc = 'コンテキストに移動' }

  -- Gitsigns
  -- Navigation
  map.n ']h' {
    desc = '次のHunkへ',
    function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() require 'gitsigns'.nav_hunk('next') end)
      return '<Ignore>'
    end,
    expr = true,
  }
  map.n '[h' {
    desc = '前のHunkへ',
    function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() require 'gitsigns'.nav_hunk('prev') end)
      return '<Ignore>'
    end,
    expr = true
  }
  -- Actions
  map.n '<space>hh' {
    desc = 'Gitsignsを読み込む',
    function()
      require 'gitsigns'
      vim.notify('Gitsigns Loaded', 'info', {
        title = 'Plugin Loading'
      })
    end,
  }
  map.n '<space>hs' { function() require 'gitsigns'.stage_hunk() end, desc = 'Hunkをステージ' }
  map.n '<space>hr' { function() require 'gitsigns'.reset_hunk() end, desc = 'Hunkをリセット' }
  map.x '<space>hs' {
    desc = '選択範囲をステージ',
    function()
      require 'gitsigns'.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
    end,
  }
  map.x '<space>hr' {
    desc = '選択範囲をリセット',
    function()
      require 'gitsigns'.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
    end
  }
  map.n '<space>hS' { function() require 'gitsigns'.stage_buffer() end, desc = 'バッファ全体をステージ' }
  map.n '<space>hu' { function() require 'gitsigns'.undo_stage_hunk() end, desc = 'ステージを取り消す' }
  map.n '<space>hR' { function() require 'gitsigns'.reset_buffer() end, desc = 'バッファ全体をリセット' }
  map.n '<space>hP' { function() require 'gitsigns'.preview_hunk() end, desc = 'Hunkをプレビュー(ポップアップ)' }
  map.n '<space>hp' { function() require 'gitsigns'.preview_hunk_inline() end, desc = 'Hunkをプレビュー' }
  map.n '<space>hb' { function() require 'gitsigns'.blame_line { full = true } end, desc = 'この行をblame' }
  map.n '<space>htb' { function() require 'gitsigns'.toggle_current_line_blame() end, desc = '行blameをトグル' }
  map.n '<space>hd' { function() require 'gitsigns'.diffthis() end, desc = 'vimdiff(diffthis)(????)' }
  map.n '<space>hD' { function() require 'gitsigns'.diffthis('~') end }
  map.n '<space>htd' { function() require 'gitsigns'.toggle_deleted() end, desc = 'Toggle Deleted' }
  map.n '<space>lh' { function() require 'gitsigns'.setqflist('all') end, desc = '未ステージのHunkの一覧' }
  -- Text object
  map.xo 'ih' { ':<C-U>Gitsigns select_hunk<CR>', desc = 'Hunk (Gitsigns)' }

  -- Fugitive
  map.n '<space>gg' { '<cmd>Git<cr><C-w>T', desc = 'git status' }
  map.n '<space>gc' { '<cmd>Git commit<cr>', desc = 'git commit' }

  -- vsnipで挿入されたスニペットのプレースホルダ間を移動するキーマップ
  vim.cmd([[
  " Jump forward or backward
  imap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
  smap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
  imap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"
  smap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"
]])

  -- telescope
  map.n '<space>fd' { function() require 'telescope.builtin'.find_files() end, desc = 'ファイル' }
  map.n '<space>ff' { '<cmd>Telescope find_files hidden=true<CR>', desc = 'ファイル(すべて)' }
  map.n '<space>fr' { function() require 'telescope.builtin'.live_grep() end, desc = 'Live grep' }
  map.n '<C-f>' { '<cmd>Telescope buffers initial_mode=normal<CR>', desc = 'バッファ選択' }
  map.n '<space>fb' { function() require 'telescope.builtin'.buffers() end, desc = 'バッファ' }
  map.n '<space>fh' { function() require 'telescope.builtin'.help_tags() end, desc = 'ヘルプファイル' }
  map.n '<space>fc' { function() require 'telescope.builtin'.commands() end, desc = 'コマンド' }
  map.n '<space>fl' { function() require 'telescope.builtin'.current_buffer_fuzzy_find() end, desc = 'カレントバッファ' }
  map.n '<space>fo' { function() require 'telescope.builtin'.oldfiles({ only_cwd = true }) end, desc = '最近のファイル(カレントディレクトリ)' }
  map.n '<space>fO' { function() require 'telescope.builtin'.oldfiles({ only_cwd = false }) end, desc = '最近のファイル(全部)' }
  map.n '<space>fu' { '<cmd>Telescope undo<CR>', desc = '履歴(Undo)' }
  map.n '<space>fn' { '<cmd>Telescope notify initial_mode=normal<CR>', desc = '通知履歴' }
  map.n '<space>fghi' { '<cmd>Telescope gh issues<CR>', desc = 'GitHub Issues' }
  map.n '<space>fghr' { '<cmd>Telescope gh pull_request<CR>', desc = 'GitHub PR プルリクエスト : <C-f> Show modified files' }
  map.n '<space>fghg' { '<cmd>Telescope gh gist<CR>', desc = 'GitHub Gist : <C-n> New' }
  map.n '<space>fghw' { '<cmd>Telescope gh run<CR>', desc = 'GitHub Workflows' }
  map.n '<space>fgb' { function() require 'telescope.builtin'.git_bcommits() end, desc = 'このファイルのコミット' }
  map.n '<space>fgc' { function() require 'telescope.builtin'.git_commits() end, desc = 'コミット' }
  map.n '<space>fgB' { function() require 'telescope.builtin'.git_branches() end, desc = 'ブランチ' }
  map.n '<space>fxo' { function() require 'telescope.builtin'.vim_options() end, desc = 'Vimオプション' }
  map.n '<space>fxa' { function() require 'telescope.builtin'.autocommands() end, desc = 'auto command' }
  map.n '<space>fxk' { function() require 'telescope.builtin'.keymaps() end, desc = 'キーマップ' }
  map.n '<space>fxp' { function() require 'telescope.builtin'.pickers() end, desc = 'Pickers' }

  -- auto-split-direction
  map.n '<C-w>a' { '<cmd>SplitAutoDirection<CR>', desc = 'いい感じに分割' }

  -- Oil.nvim
  map.n '-' { '<cmd>Oil<CR>', desc = 'ディレクトリに移動' }

  -- Rustaceanvim
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

  -- DAP
  map.n '<F5>' { function() require 'dap'.continue() end, desc = '続行' }
  map.n '<space>bc' { function() require 'dap'.continue() end, desc = '続行' }
  map.n '<F10>' { function() require 'dap'.step_over() end, desc = 'ステップ・オーバー' }
  map.n '<space>bN' { function() require 'dap'.step_over() end, desc = 'ステップ・オーバー' }
  map.n '<F11>' { function() require 'dap'.step_into() end, desc = 'ステップ・イン' }
  map.n '<space>bn' { function() require 'dap'.step_into() end, desc = 'ステップ・イン' }
  map.n '<F12>' { function() require 'dap'.step_out() end, desc = 'ステップ・アウト' }
  map.n '<space>bp' { function() require 'dap'.step_out() end, desc = 'ステップ・アウト' }
  map.n '<space>ba' { function() require 'dap'.toggle_breakpoint() end, desc = 'ブレークポイントの切り替え' }
  map.n '<Leader>b' { function() require 'dap'.toggle_breakpoint() end, desc = 'ブレークポイントの切り替え' }
  map.n '<space>bA' { function() require 'dap'.set_breakpoint() end, desc = 'ブレークポイントの設置' }
  map.n '<Leader>B' { function() require 'dap'.set_breakpoint() end, desc = 'ブレークポイントの設置' }
  map.n '<space>bl' {
    desc = 'ログ付きのブレークポイントの設置',
    function()
      require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end,
  }
  map.n '<space>bR' { function() require 'dap'.repl.open() end, desc = 'REPLを開く' }
  map.n '<space>br' { function() require 'dap'.run_last() end, desc = '最後のデバッグセッションをもう一度実行' }
  map.nx '<space>bh' { function() require 'dap.ui.widgets'.hover() end, desc = 'ホバー' }
  map.nx '<space>bv' { function() require 'dap.ui.widgets'.preview() end, desc = 'プレビュー' }
  map.n '<space>bf' {
    desc = 'フレームを表示',
    function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end,
  }
  map.n '<space>bs' {
    desc = 'スコープを表示',
    function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end,
  }
  map.n '<space>bb' { function() require 'dapui'.toggle() end, desc = 'DAP UIを開く/閉じる' }
  map.n '<space>bo' { function() require 'nvim-dap-projects'.search_project_config() end, desc = 'プロジェクト固有の設定を読み込む' }

  -- TSJ
  map.n '<space>jj' { '<cmd>TSJJoin<CR>', desc = 'TSJJoin' }
  map.n '<space>js' { '<cmd>TSJSplit<CR>', desc = 'TSJSplit' }
  map.n '<space>jt' { '<cmd>TSJToggle<CR>', desc = 'TSJToggle' }
end

return {
  register_keymaps = register_keymaps
}
