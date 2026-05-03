local command = require 'rc.util'.command

command('Manual', function()
  local lines = {
    '# Manual',
    '',
    '## 独自に定義したコマンド',
    '',
    '- `:Manual` - このマニュアルを表示する',
    '- `:Bd` - ウィンドウを閉じずにバッファを閉じる',
    '',
    '## パッシブなプラグインで、手動で読み込む必要があるもの',
    '',
    '- プラグイン名 - 読み込み方法',
    '- `vim-fugitive` - `:G`, `<space>gg`',
    '- `diffview.nvim` - `:Diffview**`',
    '- `nvim-dap-ui` - `<space>bb`',
    '',
    '## アクティブなプラグイン',
    '',
    '- プラグイン名 - 起動方法',
    '- `Oil.nvim` - `:Oil`, `-`',
    '- `telescope.nvim` - `:Telescope`, `<space>f*`',
    '- `trouble.nvim` - `:TroubleToggle`, `:TodoTrouble`, `<space>l*`',
    '- `Neogen` - `:Neogen`',
    '- `linediff.vim` - `:Linediff`',
    '- `vim-partedit` - `:Partedit`',
    '- `suda.vim` - `:Suda**`',
    '- `vim-qfreplace` - `:Qfreplace`',
    '- `auto-split-direction` - `:SplitAutoDirection`, `<C-W>a`',
    '- `treesj` - `:TSJ**`, `<space>j*`',
    '- `vim-maketable` - `:MakeTable`',
    '- `neotest` - `:Neotest summary`',
    '- `rustaceanvim` - `RustLsp *`',
    '',
    '## その他のメモ',
    '',
    '### 自動フォーマット',
    '',
    '保存時に自動でフォーマットされます。無効にするには `:let b:no_format=1` を実行します。',
    '',
  }
  local tmpbuf = vim.api.nvim_create_buf(false, true)
  local height = math.min(math.floor(vim.o.lines * 0.8), #lines)
  local width = math.min(math.floor(vim.o.columns * 0.8), 120)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  vim.api.nvim_open_win(tmpbuf, true, {
    row = row,
    col = col,
    width = width,
    height = height,
    relative = 'editor',
    style = 'minimal',
    border = 'rounded',
  })
  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = tmpbuf })
  vim.api.nvim_put(lines, 'l', false, false)
  vim.api.nvim_set_option_value('modifiable', false, { buf = tmpbuf })
  vim.api.nvim_buf_set_keymap(tmpbuf, 'n', '<ESC>', '<cmd>q<cr>', {})
end)

-- ウィンドウを閉じずにバッファを閉じる
-- https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window
command('Bd', 'bp|bd#')
