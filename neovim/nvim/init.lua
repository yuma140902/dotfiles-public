require 'rc/disable_default_plugins'

-- lazy.nvim(プラグインマネージャ)を自動インストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup 'plugins'

require 'rc/base'

-- キーマップの設定
require 'keymaps'.register_keymaps()

vim.o.guifont = 'HackGen Console NF:h10'
vim.o.autochdir = false
if vim.g.neovide then
  require 'neovide'
end
