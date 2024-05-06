local command = require 'rc.lib'.command

command('Manual', function()
  local tmpbuf = vim.api.nvim_create_buf(false, true)
  local height = math.floor(vim.o.lines * 0.8)
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
  })
  vim.api.nvim_buf_set_option(tmpbuf, 'filetype', 'markdown')
  vim.api.nvim_put({
    "# Manual",
    "",
    "## 独自に定義したコマンド",
    "",
    "- `:Manual` - このマニュアルを表示する",
    "- `:Now` - CursorHold/Iイベントで読み込まれるプラグインを即座にまとめて読み込む",
    "- `:Bd` - ウィンドウを閉じずにバッファを閉じる",
    "",
    "## パッシブなプラグインで、手動で読み込む必要があるもの",
    "",
    "- プラグイン名 - 読み込み方法",
    "- `vim-fugitive` - `:G`, `<space>gg`",
    "- `diffview.nvim` - `:Diffview**`",
    "- `nvim-dap-ui` - `<space>bb`",
    "- `twilight.nvim` - `:Twilight`",
    "",
    "## パッシブなプラグインで、CursorHold/Iで読み込まれるもの",
    "",
    "`:Now`でまとめて読み込むことができる",
    "",
    "- プラグイン名 - 即座に読み込む方法",
    "- `nvim-scrollview` - `:Lazy load nvim-scrollview`",
    "- `gitsigns.nvim` - `:Gitsigns`, `<space>hh`",
    "- `hlchunk.nvim` - `:EnableHL`",
    "",
    "## アクティブなプラグイン",
    "",
    "- プラグイン名 - 起動方法",
    "- `Oil.nvim` - `:Oil`, `-`",
    "- `telescope.nvim` - `:Telescope`, `<space>f*`",
    "- `trouble.nvim` - `:TroubleToggle`, `:TodoTrouble`, `<space>l*`",
    "- `Neogen` - `:Neogen`",
    "- `ferris.nvim` - `:Ferris**`",
    "- `linediff.vim` - `:Linediff`",
    "- `vim-partedit` - `:Partedit`",
    "- `suda.vim` - `:Suda**`",
    "- `vim-qfreplace` - `:Qfreplace`",
    "- `auto-split-direction` - `:SplitAutoDirection`, `<C-W>a`",
    "",
  }, "l", false, false)
  vim.api.nvim_buf_set_option(tmpbuf, 'modifiable', false)
end)

command('Now', function()
  vim.cmd('Lazy load nvim-scrollview')
  vim.cmd('Lazy load gitsigns.nvim')
  vim.cmd('Lazy load hlchunk.nvim')
end)

-- ウィンドウを閉じずにバッファを閉じる
-- https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window
command('Bd', 'bp|bd#')
