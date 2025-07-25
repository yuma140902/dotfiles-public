-- 基本的な設定

-- 基本
vim.opt.number = false
vim.opt.mouse = 'a'
vim.opt.fileformats = 'unix,dos'

-- インデント関係
vim.opt.expandtab = true      -- タブ文字が入力されたとき、スペース文字に変える
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2        -- '>>'等で入力されるインデントの深さ
vim.opt.softtabstop = 2       -- 2つのスペースを一文字であるかのように扱う

vim.opt.virtualedit = 'block' -- 矩形選択で文字が無い部分にカーソルを移動できる

vim.opt.scrolloff = 3

vim.opt.ambiwidth = 'single' -- use rbtnn/vim-ambiwidth

vim.opt.laststatus = 2

-- 検索
vim.opt.smartcase = true -- 検索ワードが小文字のみなら大文字小文字を無視
vim.opt.wrapscan = true  -- 最後まで検索したら最初に戻る
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true

-- ターミナル
local terminal_augroup = vim.api.nvim_create_augroup('terminal_augroup', { clear = true })

-- ターミナルのバッファでは行番号非表示
vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_augroup,
  pattern = '*',
  command = 'setlocal nonumber'
})

-- ターミナルのバッファを判別するための変数を設定
vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    vim.b.this_is_a_terminal_buffer = true
  end
})

-- ターミナルウィンドウに切り替わったら自動的にインサートモードへ入る
vim.api.nvim_create_autocmd('BufEnter', {
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    if vim.b.this_is_a_terminal_buffer then
      vim.cmd('startinsert')
    end
  end
})

-- シェル
if vim.fn.has('win32') == 1 then
  -- WindowsではシェルはPowershellとする
  -- see also :help shell-powershell
  if vim.fn.executable('pwsh') then
    vim.opt.shell = 'pwsh'
  else
    vim.opt.shell = 'powershell'
  end
  vim.opt.shellcmdflag =
  '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

-- 自動でquickfix windowを開く
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = vim.api.nvim_create_augroup('auto_open_quickfix_window', { clear = true }),
  pattern = '*',
  nested = true,
  command = 'cwindow'
})

-- フローティングウィンドウを半透明にする
vim.api.nvim_win_set_option(0, 'winblend', require 'rc.lib'.default_winblend())
vim.opt.pumblend = require 'rc.lib'.default_winblend()

-- 組み込みのLSPクライアントの設定
vim.diagnostic.config({
  severity_sort = true,
})
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_setup', { clear = true }),
  pattern = '*',
  callback = function()
    vim.lsp.inlay_hint.enable(true)
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    local on_attach = require 'rc.lib'.on_attach
    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
})

-- UIEnterのあと一定時間後にUser UIEnterPostイベントを発生させる
vim.api.nvim_create_autocmd('UIEnter', {
  group = vim.api.nvim_create_augroup('UIEnterDelay', { clear = true }),
  pattern = '*',
  nested = true,
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "UIEnterPost",
        modeline = false,
      })
    end, 600)
  end
})
