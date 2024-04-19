-- GUIに関する設定

if vim.fn.has 'win32' == 1 then
  vim.o.guifont = 'PlemolJP Console NF:h10'
else
  vim.o.guifont = 'PlemolJP Console NF:h14'
end
vim.o.autochdir = false
if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
end
