local map = require 'rc/lib'.map

local function register_keymaps()
  require 'which-key'.register({
    l = { name = 'trouble.nvim(画面下のリスト開閉)' },
    x = {
      name = 'IDE-like Neovim(エイリアス)',
      g = { name = '移動系' },
      v = { name = '表示系' },
      e = { name = '編集系' }
    },
    h = {
      name = 'gitsigns',
      t = { name = 'トグル系' }
    },
    g = {
      name = 'fugitive'
    },
    f = {
      name = 'Telescope(ファジーファインダ)',
      g = {
        name = 'Git関係',
        h = { name = 'GitHub関係 <C-T>でブラウザで開く' }
      },
      x = { name = 'EXTRA' }
    },
    c = {
      name = 'crates.nvim'
    },
    r = {
      name = 'Rustaceanvim'
    },
    b = {
      name = 'デバッグ'
    },
    t = { name = "ターミナル" }
  }, { prefix = '<space>' })

  -- バニラ
  map('n', '[b', '<cmd>bprev<cr>', '前のバッファ')
  map('n', ']b', '<cmd>bnext<cr>', '次のバッファ')
  map('n', '<C-c>', '<cmd>bp|bd #<cr>', 'バッファを閉じる(ウィンドウを閉じない)') -- https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window
  local open = 'xdg-open'
  if vim.fn.has('mac') == 1 then
    open = 'open'
  elseif vim.fn.has('win32') == 1 then
    open = 'start'
  end
  map({ 'n', 'x' }, 'gx', '<cmd>silent !' .. open .. ' <cfile><cr>', '標準アプリで開く')

  -- タブ
  map('n', '<C-H>', '<cmd>tabprev<cr>')
  map('n', '<C-L>', '<cmd>tabnext<cr>')

  -- バニラ - ターミナル
  map('n', '<space>tn', '<cmd>terminal<cr>', 'ターミナルを開く')
  map('n', '<space>tt', '<cmd>tabnew<cr><cmd>terminal<cr><cmd>startinsert<cr>', 'ターミナルを新規タブで開く')
  map('n', '<space>tf', '<cmd>Lspsaga term_toggle<cr>', 'floating windowのターミナルをトグル')
  map({ 'n', 't' }, '<A-d>', '<cmd>Lspsaga term_toggle<cr>', 'floating windowのターミナルをトグル')
  map('n', '<space>tj', '<cmd>belowright new<cr><cmd>terminal<cr><cmd>startinsert<cr>', 'ターミナルを下に開く')
  map('n', '<space>tl', '<C-W>v<C-W>l<cmd>terminal<cr><cmd>startinsert<cr>', 'ターミナルを左に開く')

  map('t', '<C-H>', '<cmd>tabprev<cr>')
  map('t', '<C-L>', '<cmd>tabnext<cr>')

  map('t', '<C-\\>', '<C-\\><C-n>', 'ターミナルノーマルモード')
  map('t', '<C-W>n', '<cmd>new<cr>')
  map('t', '<C-W><C-N>', '<cmd>new<cr>')
  map('t', '<C-W>q', '<cmd>quit<cr>')
  map('t', '<C-W><C-Q>', '<cmd>quit<cr>')
  map('t', '<C-W>c', '<cmd>close<cr>')
  map('t', '<C-W>o', '<cmd>only<cr>')
  map('t', '<C-W><C-O>', '<cmd>only<cr>')
  map('t', '<C-W><Down>', '<cmd>wincmd j<cr>')
  map('t', '<C-W><C-J>', '<cmd>wincmd j<cr>')
  map('t', '<C-W>j', '<cmd>wincmd j<cr>')
  map('t', '<C-W><Up>', '<cmd>wincmd k<cr>')
  map('t', '<C-W><C-K>', '<cmd>wincmd k<cr>')
  map('t', '<C-W>k', '<cmd>wincmd k<cr>')
  map('t', '<C-W><Left>', '<cmd>wincmd h<cr>')
  map('t', '<C-W><C-H>', '<cmd>wincmd h<cr>')
  map('t', '<C-W><BS>', '<cmd>wincmd h<cr>')
  map('t', '<C-W>h', '<cmd>wincmd h<cr>')
  map('t', '<C-W><Right>', '<cmd>wincmd l<cr>')
  map('t', '<C-W><C-L>', '<cmd>wincmd l<cr>')
  map('t', '<C-W>l', '<cmd>wincmd l<cr>')
  map('t', '<C-W>w', '<cmd>wincmd w<cr>')
  map('t', '<C-W><C-W>', '<cmd>wincmd w<cr>')
  map('t', '<C-W>W', '<cmd>wincmd W<cr>')
  map('t', '<C-W>t', '<cmd>wincmd t<cr>')
  map('t', '<C-W><C-T>', '<cmd>wincmd t<cr>')
  map('t', '<C-W>b', '<cmd>wincmd b<cr>')
  map('t', '<C-W><C-B>', '<cmd>wincmd b<cr>')
  map('t', '<C-W>p', '<cmd>wincmd p<cr>')
  map('t', '<C-W><C-P>', '<cmd>wincmd p<cr>')
  map('t', '<C-W>P', '<cmd>wincmd P<cr>')
  map('t', '<C-W>r', '<cmd>wincmd r<cr>')
  map('t', '<C-W><C-R>', '<cmd>wincmd r<cr>')
  map('t', '<C-W>R', '<cmd>wincmd R<cr>')
  map('t', '<C-W>x', '<cmd>wincmd x<cr>')
  map('t', '<C-W><C-X>', '<cmd>wincmd x<cr>')
  map('t', '<C-W>K', '<cmd>wincmd K<cr>')
  map('t', '<C-W>J', '<cmd>wincmd J<cr>')
  map('t', '<C-W>H', '<cmd>wincmd H<cr>')
  map('t', '<C-W>L', '<cmd>wincmd L<cr>')
  map('t', '<C-W>T', '<cmd>wincmd T<cr>')
  map('t', '<C-W>=', '<cmd>wincmd =<cr>')
  map('t', '<C-W>-', '<cmd>wincmd -<cr>')
  map('t', '<C-W>+', '<cmd>wincmd +<cr>')
  map('t', '<C-W>z', '<cmd>pclose<cr>')
  map('t', '<C-W><C-Z>', '<cmd>pclose<cr>')

  -- LSP関係
  map('n', 'gD', '<cmd>Lspsaga goto_type_definition<cr>', '[LSP] 型の定義へ移動')
  map('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', '[LSP] 定義へ移動')
  map('n', 'gi', '<cmd>Lspsaga finder imp<cr>', '[LSP] 実装へ移動')
  map('n', '<space>D', vim.lsp.buf.type_definition, '変数の型の定義へ移動')
  map('n', '<space>xgD', vim.lsp.buf.declaration, '宣言へ移動')
  map('n', '<space>xgd', vim.lsp.buf.definition, '定義へ移動')
  map('n', '<space>xgi', vim.lsp.buf.implementation, '実装へ移動')

  map('n', '<space>o', function() vim.lsp.buf.format { async = true } end, 'コードフォーマットする')
  map('n', '<space>xef', function() vim.lsp.buf.format { async = true } end, 'コードフォーマットする')
  map('n', 'gr', '<cmd>Lspsaga finder ref+def<cr>', '[LSP] 参照・定義へ移動')
  map('n', 'gR', '<cmd>Lspsaga finder ref+def+imp<cr>', '[LSP] 参照・定義・実装へ移動')
  map('n', 'gI', '<cmd>Lspsaga incoming_calls<cr>', '[LSP] incoming callsを表示')
  map('n', 'gO', '<cmd>Lspsaga outgoing_calls<cr>', '[LSP] outgoing callsを表示')
  map('n', 'K', '<cmd>Lspsaga hover_doc<cr>', 'ドキュメント表示')
  --map('n', '<C-k>', '<cmd>Lspsaga signature_help<cr>', 'シグネチャを表示')
  map('n', '<space>R', '<cmd>Lspsaga rename<cr>', 'リネームする')
  map('n', '<space>a', '<cmd>Lspsaga code_action<cr>', 'コードアクションを表示')
  map('x', '<space>a', '<cmd>Lspsaga range_code_action<cr>', 'コードアクションを表示')
  map('n', '<space>xvk', '<cmd>Lspsaga hover_doc<cr>', 'ドキュメント表示')
  map('n', '<space>xvs', '<cmd>Lspsaga signature_help<cr>', 'シグネチャを表示')
  map('n', '<space>xer', '<cmd>Lspsaga rename<cr>', 'リネームする')
  map('n', '<space>xva', '<cmd>Lspsaga code_action<cr>', 'コードアクションを表示')
  map('x', '<space>xva', '<cmd>Lspsaga range_code_action<cr>', 'コードアクションを表示')

  -- 診断関係
  -- :h vim.diagnostic.*
  map('n', '<space>d', '<cmd>Lspsaga show_line_diagnostics<cr>', '診断(エラーメッセージ等)をフロート表示')
  map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', '前の診断へ')
  map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', '次の診断へ')
  map('n', '<space>xve', '<cmd>Lspsaga show_line_diagnostics<cr>', '診断(エラーメッセージ等)をフロート表示')
  map('n', '<space>xgD', '<cmd>Lspsaga diagnostic_jump_prev<cr>', '前の診断へ')
  map('n', '<space>xgd', '<cmd>Lspsaga diagnostic_jump_next<cr>', '次の診断へ')

  -- trouble.nvim
  map('n', '<space>lx', '<cmd>TroubleToggle<cr>', 'トグル');
  map('n', '<down>', '<cmd>TroubleToggle<cr>', 'トグル');
  map('n', '<space>ld', '<cmd>TroubleToggle document_diagnostics<cr>', '現在のファイルの診断情報');
  map('n', '<space>lw', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'プロジェクト全体の診断情報');
  map('n', '<space>ll', '<cmd>TroubleToggle loclist<cr>', 'loclist');
  map('n', '<space>lq', '<cmd>TroubleToggle quickfix<cr>', 'QuickFix');
  map('n', '<space>xvd', '<cmd>TroubleToggle document_diagnostics<cr>', '現在のファイルの診断情報');
  map('n', '<space>xvw', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'プロジェクト全体の診断情報');

  -- todo-comments.nvim
  map('n', '<space>lt', '<cmd>TodoTrouble<cr>', 'TODOコメント');
  map('n', '<space>ft', '<cmd>TodoTelescope<cr>', 'TODOコメント');
  map('n', '[t', function() require 'todo-comments'.jump_next() end, '次のTODOコメントへ');
  map('n', ']t', function() require 'todo-comments'.jump_prev() end, '前のTODOコメントへ');
  map('n', '<space>xvt', '<cmd>TodoTrouble<cr>', 'TODOコメント');
  map('n', '<space>xgt', function() require 'todo-comments'.jump_next() end, '次のTODOコメントへ');
  map('n', '<space>xgT', function() require 'todo-comments'.jump_prev() end, '前のTODOコメントへ');

  -- aerial
  map('n', '<space><space>', '<cmd>AerialToggle float<cr>', 'Aerialを開く')
  map('n', '<right>', '<cmd>AerialToggle! right<cr>', 'Aerialを開閉')
  map('n', ']]', '<cmd>AerialNext<cr>', 'AerialNext')
  map('n', '[[', '<cmd>AerialPrev<cr>', 'AerialPrev')

  map('n', '[c', function() require("treesitter-context").go_to_context() end, 'コンテキストに移動')

  -- Gitsigns
  -- Navigation
  map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() require 'gitsigns'.next_hunk() end)
      return '<Ignore>'
    end,
    '次のHunkへ',
    { expr = true })
  map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() require 'gitsigns'.prev_hunk() end)
      return '<Ignore>'
    end,
    '前のHunkへ',
    { expr = true })
  -- Actions
  map('n', '<space>hh', function()
    require 'gitsigns'
    vim.notify('Gitsigns Loaded', 'info', {
      title = 'Plugin Loading'
    })
  end, 'Gitsignsを読み込む')
  map('n', '<space>hs', function() require 'gitsigns'.stage_hunk() end, 'Hunkをステージ')
  map('n', '<space>hr', function() require 'gitsigns'.reset_hunk() end, 'Hunkをリセット')
  map('v', '<space>hs', function()
    require 'gitsigns'.stage_hunk {
      vim.fn.line("."), vim.fn.line("v") }
  end, '選択範囲をステージ')
  map('v', '<space>hr', function()
    require 'gitsigns'.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
  end, '選択範囲をリセット')
  map('n', '<space>hS', function() require 'gitsigns'.stage_buffer() end, 'バッファ全体をステージ')
  map('n', '<space>hu', function() require 'gitsigns'.undo_stage_hunk() end, 'ステージを取り消す')
  map('n', '<space>hR', function() require 'gitsigns'.reset_buffer() end, 'バッファ全体をリセット')
  map('n', '<space>hP', function() require 'gitsigns'.preview_hunk() end, 'Hunkをプレビュー(ポップアップ)')
  map('n', '<space>hp', function() require 'gitsigns'.preview_hunk_inline() end, 'Hunkをプレビュー')
  map('n', '<space>hb', function() require 'gitsigns'.blame_line { full = true } end, 'この行をblame')
  map('n', '<space>htb', function() require 'gitsigns'.toggle_current_line_blame() end, '行blameをトグル')
  map('n', '<space>hd', function() require 'gitsigns'.diffthis() end, 'vimdiff(diffthis)(????)')
  map('n', '<space>hD', function() require 'gitsigns'.diffthis('~') end)
  map('n', '<space>htd', function() require 'gitsigns'.toggle_deleted() end, 'Toggle Deleted')
  map('n', '<space>lh', function() require 'gitsigns'.setqflist('all') end, '未ステージのHunkの一覧')
  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

  -- Fugitive
  map('n', '<space>gg', '<cmd>Git<cr><C-w>T', 'git status')
  map('n', '<space>gc', '<cmd>Git commit<cr>', 'git commit')

  -- vsnipで挿入されたスニペットのプレースホルダ間を移動するキーマップ
  vim.cmd([[
  " Jump forward or backward
  imap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
  smap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
  imap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"
  smap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"
]])

  -- telescope
  map('n', '<space>fd', function() require 'telescope.builtin'.find_files() end, 'ファイル')
  map('n', '<space>ff', '<cmd>Telescope find_files hidden=true<cr>', 'ファイル(すべて)')
  map('n', '<space>fr', function() require 'telescope.builtin'.live_grep() end, 'Live grep')
  map('n', '<C-f>', '<cmd>Telescope buffers initial_mode=normal<cr>', 'バッファ選択')
  map('n', '<space>fb', function() require 'telescope.builtin'.buffers() end, 'バッファ')
  map('n', '<space>fh', function() require 'telescope.builtin'.help_tags() end, 'ヘルプファイル')
  map('n', '<space>fc', function() require 'telescope.builtin'.commands() end, 'コマンド')
  map('n', '<space>fl', function() require 'telescope.builtin'.current_buffer_fuzzy_find() end, 'カレントバッファ')
  map('n', '<space>fo', function() require 'telescope.builtin'.oldfiles({ only_cwd = true }) end, '最近のファイル(カレントディレクトリ)')
  map('n', '<space>fO', function() require 'telescope.builtin'.oldfiles({ only_cwd = false }) end, '最近のファイル(全部)')
  map('n', '<space>fu', '<cmd>Telescope undo<cr>', '履歴(Undo)')
  map('n', '<space>fp', '<cmd>Telescope command_palette<cr>', 'コマンドパレット')
  map('n', '<space>fn', '<cmd>Telescope notify initial_mode=normal<cr>', '通知履歴')
  map('n', '<up>', '<cmd>Telescope command_palette<cr>', 'コマンドパレット')
  map('n', '<space>fghi', '<cmd>Telescope gh issues<cr>', 'GitHub Issues')
  map('n', '<space>fghr', '<cmd>Telescope gh pull_request<cr>', 'GitHub PR プルリクエスト : <C-f> Show modified files')
  map('n', '<space>fghg', '<cmd>Telescope gh gist<cr>', 'GitHub Gist : <C-n> New')
  map('n', '<space>fghw', '<cmd>Telescope gh run<cr>', 'GitHub Workflows')
  map('n', '<space>fgb', function() require 'telescope.builtin'.git_bcommits() end, 'このファイルのコミット')
  map('n', '<space>fgc', function() require 'telescope.builtin'.git_commits() end, 'コミット')
  map('n', '<space>fgB', function() require 'telescope.builtin'.git_branches() end, 'ブランチ')
  map('n', '<space>fxo', function() require 'telescope.builtin'.vim_options() end, 'Vimオプション')
  map('n', '<space>fxa', function() require 'telescope.builtin'.autocommands() end, 'auto command')
  map('n', '<space>fxk', function() require 'telescope.builtin'.keymaps() end, 'キーマップ')
  map('n', '<space>fxp', function() require 'telescope.builtin'.pickers() end, 'Pickers')

  -- auto-split-direction
  map('n', '<C-w>a', '<cmd>SplitAutoDirection<cr>', 'いい感じに分割')

  -- Oil.nvim
  map('n', '-', '<cmd>Oil<cr>', 'ディレクトリに移動')

  -- Rustaceanvim
  map('n', '<space>rB', '<cmd>RustLsp debuggables<cr>', 'DAPでデバッグ')
  map('n', '<space>rb', '<cmd>RustLsp debuggables last<cr>', '最後のターゲットをDAPでデバッグ')
  map('n', '<space>rR', '<cmd>RustLsp runnables<cr>', '実行')
  map('n', '<space>rr', '<cmd>RustLsp runnables last<cr>', '最後のターゲットを実行')
  map({ 'n', 'v' }, '<space>rm', '<cmd>RustLsp expandMacro<cr>', 'マクロを再帰的に展開')
  map({ 'n', 'v' }, '<space>rP', '<cmd>RustLsp rebuildProcMacros<cr>', 'proc macroを再ビルド')
  map({ 'n', 'v' }, '<space>r[', '<cmd>RustLsp moveItem up<cr>', 'アイテムを上に移動')
  map({ 'n', 'v' }, '<space>r]', '<cmd>RustLsp moveItem down<cr>', 'アイテムを下に移動')
  map({ 'n', 'v' }, '<space>ra', '<cmd>RustLsp hover actions<cr>', 'Hover Actionsを表示')
  map({ 'n', 'v' }, '<space>rA', '<cmd>RustLsp hover range<cr>', 'Hover Rangeを表示')
  map('n', '<space>rd', '<cmd>RustLsp explainError<cr>', 'エラーの解説を表示')
  map('n', '<space>rC', '<cmd>RustLsp openCargo<cr>', 'Cargo.tomlを表示')
  map('n', '<space>rp', '<cmd>RustLsp parentModule<cr>', '親モジュール')
  map({ 'n', 'v' }, '<space>rJ', '<cmd>RustLsp joinLines<cr>', '行を結合')
  map({ 'n', 'v' }, '<space>rs', '<cmd>RustLsp syntaxTree<cr>', '構文木を表示')
  map('n', '<space>rc', '<cmd>RustLsp flyCheck<cr>', 'fly-checkを実行')

  -- DAP
  map('n', '<F5>', function() require 'dap'.continue() end, '続行')
  map('n', '<space>bc', function() require 'dap'.continue() end, '続行')
  map('n', '<F10>', function() require 'dap'.step_over() end, 'ステップ・オーバー')
  map('n', '<space>bN', function() require 'dap'.step_over() end, 'ステップ・オーバー')
  map('n', '<F11>', function() require 'dap'.step_into() end, 'ステップ・イン')
  map('n', '<space>bn', function() require 'dap'.step_into() end, 'ステップ・イン')
  map('n', '<F12>', function() require 'dap'.step_out() end, 'ステップ・アウト')
  map('n', '<space>bp', function() require 'dap'.step_out() end, 'ステップ・アウト')
  map('n', '<space>ba', function() require 'dap'.toggle_breakpoint() end, 'ブレークポイントの切り替え')
  map('n', '<Leader>b', function() require 'dap'.toggle_breakpoint() end, 'ブレークポイントの切り替え')
  map('n', '<space>bA', function() require 'dap'.set_breakpoint() end, 'ブレークポイントの設置')
  map('n', '<Leader>B', function() require 'dap'.set_breakpoint() end, 'ブレークポイントの設置')
  map('n', '<space>bl', function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    'ログ付きのブレークポイントの設置')
  map('n', '<space>bR', function() require 'dap'.repl.open() end, 'REPLを開く')
  map('n', '<space>br', function() require 'dap'.run_last() end, '最後のデバッグセッションをもう一度実行')
  map({ 'n', 'v' }, '<space>bh', function() require 'dap.ui.widgets'.hover() end, 'ホバー')
  map({ 'n', 'v' }, '<space>bv', function() require 'dap.ui.widgets'.hover() end, 'プレビュー')
  map('n', '<space>bf', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, 'フレームを表示')
  map('n', '<space>bs', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, 'スコープを表示')
  map('n', '<space>bb', function() require 'dapui'.toggle() end, 'DAP UIを開く/閉じる')
  map('n', '<space>bo', function() require 'nvim-dap-projects'.search_project_config() end, 'プロジェクト固有の設定を読み込む')
end

return {
  register_keymaps = register_keymaps
}
