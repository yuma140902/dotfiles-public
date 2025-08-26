-- 高速化のためにデフォルトプラグインの一部を無効化する
-- https://qiita.com/yasunori-kirin0418/items/4672919be73a524afb47#%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AE%E7%84%A1%E5%8A%B9%E5%8C%96

-- Disable :TOhtml
vim.g.loaded_2html_plugin      = 1

-- 圧縮ファイルを読み書きするプラグイン
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1

-- vimball
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1

-- nvim-treeを使うためnetrwを読み込まない
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
