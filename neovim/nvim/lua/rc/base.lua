-- 基本的な設定

-- 基本
vim.opt.number = false
vim.opt.mouse = 'a'
vim.opt.fileformats = 'unix,dos'

-- インデント
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.autoindent = true

-- ビジュアルモード
vim.opt.virtualedit = 'block' -- 矩形選択で文字が無い部分にカーソルを移動できる

-- エディタの見た目
vim.opt.scrolloff = 3
vim.opt.ambiwidth = 'single' -- 後から rbtnn/vim-ambiwidth でいい感じに設定する
vim.opt.foldcolumn = 'auto'
vim.opt.laststatus = 2

vim.opt.formatoptions:append('M')

vim.opt.timeout = true
vim.opt.timeoutlen = 1000

-- 検索
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true

-- ターミナル
local terminal_augroup = vim.api.nvim_create_augroup('terminal_augroup', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    -- ターミナルのバッファでは行番号非表示
    vim.opt_local.number = false
    -- ターミナルのバッファを判別するための変数を設定
    vim.b.this_is_a_terminal_buffer = true

    vim.cmd.startinsert()
  end
})

-- ターミナルのバッファに入ったとき自動でインサートモードに入る
vim.api.nvim_create_autocmd('BufEnter', {
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    if vim.b.this_is_a_terminal_buffer then
      vim.cmd.startinsert()
    end
  end
})

-- シェル
if vim.fn.has('win32') == 1 then
  -- Windows ではシェルは PowerShell を使う
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

vim.diagnostic.config {
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_setup', { clear = true }),
  pattern = '*',
  callback = function()
    vim.lsp.inlay_hint.enable(true)
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    vim.lsp.config('*', {
      capabilities = capabilities,
    })
  end
})

-- UIEnter から一定時間後に User UIEnterPost イベントを発生させる
vim.api.nvim_create_autocmd('UIEnter', {
  group = vim.api.nvim_create_augroup('ui_enter_post', { clear = true }),
  pattern = '*',
  nested = true,
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds('User', {
        pattern = 'UIEnterPost',
        modeline = false,
      })
    end, 600)
  end
})
