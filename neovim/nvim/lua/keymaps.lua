local use_lspsaga_keymaps = true

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
    }
  }, { prefix = '<space>' })

  require 'which-key'.register({
    t = { name = "ターミナル" }
  })

  -- バニラ
  map('n', '[b', '<cmd>bprev<cr>', '前のバッファ')
  map('n', ']b', '<cmd>bnext<cr>', '次のバッファ')
  map('n', '<C-c>', '<cmd>bp|bd #<cr>', 'バッファを閉じる(ウィンドウを閉じない)')  -- https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window

  -- タブ
  map('n', '<C-H>', '<cmd>tabprev<cr>')
  map('n', '<C-L>', '<cmd>tabnext<cr>')

  -- バニラ - ターミナル
  map('n', 'tn', '<cmd>terminal<cr>', 'ターミナルを開く')
  map('n', 'tt', '<cmd>tabnew<cr><cmd>terminal<cr><cmd>startinsert<cr>', 'ターミナルを新規タブで開く')
  map('n', 'tj', '<cmd>belowright new<cr><cmd>terminal<cr><cmd>startinsert<cr>', 'ターミナルを下に開く')
  map('n', 'tl', '<C-W>v<C-W>l<cmd>terminal<cr><cmd>startinsert<cr>', 'ターミナルを左に開く')

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
  map('n', 'gD', vim.lsp.buf.declaration, '[LSP] 宣言へ移動')
  map('n', 'gd', vim.lsp.buf.definition, '[LSP] 定義へ移動')
  map('n', 'gi', vim.lsp.buf.implementation, '[LSP] 実装へ移動')
  map('n', '<space>D', vim.lsp.buf.type_definition, '変数の型の定義へ移動')
  map('n', '<space>xgD', vim.lsp.buf.declaration, '宣言へ移動')
  map('n', '<space>xgd', vim.lsp.buf.definition, '定義へ移動')
  map('n', '<space>xgi', vim.lsp.buf.implementation, '実装へ移動')

  map('n', '<space>o', function() vim.lsp.buf.format { async = true } end, 'コードフォーマットする')
  map('n', '<space>xef', function() vim.lsp.buf.format { async = true } end, 'コードフォーマットする')
  if use_lspsaga_keymaps then
    map('n', 'gr', '<cmd>Lspsaga lsp_finder<cr>', '[LSP] 参照へ移動')
    map('n', 'K', '<cmd>Lspsaga hover_doc<cr>', 'ドキュメント表示')
    map('n', '<C-k>', '<cmd>Lspsaga signature_help<cr>', 'シグネチャを表示')
    map('n', '<space>r', '<cmd>Lspsaga rename<cr>', 'リネームする')
    map('n', '<space>a', '<cmd>Lspsaga code_action<cr>', 'コードアクションを表示')
    map('x', '<space>a', '<cmd>Lspsaga range_code_action<cr>', 'コードアクションを表示')
    map('n', '<space>xgr', '<cmd>Lspsaga lsp_finder<cr>', '参照へ移動')
    map('n', '<space>xvk', '<cmd>Lspsaga hover_doc<cr>', 'ドキュメント表示')
    map('n', '<space>xvs', '<cmd>Lspsaga signature_help<cr>', 'シグネチャを表示')
    map('n', '<space>xer', '<cmd>Lspsaga rename<cr>', 'リネームする')
    map('n', '<space>xva', '<cmd>Lspsaga code_action<cr>', 'コードアクションを表示')
    map('x', '<space>xva', '<cmd>Lspsaga range_code_action<cr>', 'コードアクションを表示')
  else
    map('n', 'gr', vim.lsp.buf.references, '[LSP] 参照へ移動')
    map('n', 'K', vim.lsp.buf.hover, 'ドキュメント表示')
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'シグネチャを表示')
    map('n', '<space>r', vim.lsp.buf.rename, 'リネームする')
    map('n', '<space>a', vim.lsp.buf.code_action, 'コードアクションを表示')
    map('n', '<space>xgr', vim.lsp.buf.references, '参照へ移動')
    map('n', '<space>xvk', vim.lsp.buf.hover, 'ドキュメント表示')
    map('n', '<space>xvs', vim.lsp.buf.signature_help, 'シグネチャを表示')
    map('n', '<space>xer', vim.lsp.buf.rename, 'リネームする')
    map('n', '<space>xva', vim.lsp.buf.code_action, 'コードアクションを表示')
  end

  -- 診断関係
  -- :h vim.diagnostic.*
  if use_lspsaga_keymaps then
    map('n', '<space>d', '<cmd>Lspsaga show_line_diagnostics<cr>', '診断(エラーメッセージ等)をフロート表示')
    map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', '前の診断へ')
    map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', '次の診断へ')
    map('n', '<space>xve', '<cmd>Lspsaga show_line_diagnostics<cr>', '診断(エラーメッセージ等)をフロート表示')
    map('n', '<space>xgD', '<cmd>Lspsaga diagnostic_jump_prev<cr>', '前の診断へ')
    map('n', '<space>xgd', '<cmd>Lspsaga diagnostic_jump_next<cr>', '次の診断へ')
  else
    map('n', '<space>d', vim.diagnostic.open_float, '診断(エラーメッセージ等)をフロート表示')
    map('n', '[d', vim.diagnostic.goto_prev, '前の診断へ')
    map('n', ']d', vim.diagnostic.goto_next, '次の診断へ')
    map('n', '<space>xve', vim.diagnostic.open_float, '診断(エラーメッセージ等)をフロート表示')
    map('n', '<space>xgD', vim.diagnostic.goto_prev, '前の診断へ')
    map('n', '<space>xgd', vim.diagnostic.goto_next, '次の診断へ')
  end

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
  map('n', '<space>m', '<cmd>AerialOpen<cr>', 'Aerialを開く')
  map('n', '<right>', '<cmd>AerialOpen<cr>', 'Aerialを開く')
  map('n', ']]', '<cmd>AerialNext<cr>', 'AerialNext')
  map('n', '[[', '<cmd>AerialPrev<cr>', 'AerialPrev')
  map('n', '{', '<cmd>AerialPrev<CR>', 'AerialNext')
  map('n', '}', '<cmd>AerialNext<CR>', 'AerialPrev')

  -- jujmpcursor.vim
  map('n', '[j', '<Plug>(jumpcursor-jump)', 'jumpcursor.vimで移動')

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

  -- NvimTree
  map('n', '<space>t', '<cmd>NvimTreeToggle<cr>', 'NvimTreeをトグル')
  map('n', '<left>', '<cmd>NvimTreeToggle<cr>', 'NvimTreeをトグル')

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
  map('n', '<space>b', '<cmd>Telescope buffers initial_mode=normal<cr>', 'バッファ選択')
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
end

return {
  register_keymaps = register_keymaps
}
