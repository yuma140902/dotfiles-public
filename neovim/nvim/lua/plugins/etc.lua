return {
  {
    'navarasu/onedark.nvim', -- カラースキーム
    lazy = false,            -- メインのカラースキームは確実に非同期で読み込むようにするらしい
    priority = 1000,         -- メインのカラースキームは他のプラグインよりも先に読み込まれるのが良いらしい
    config = function()
      vim.opt.termguicolors = true
      vim.opt.cursorline = true
      require 'onedark'.load()
    end
  },
  -- ファイラ
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require 'nvim-tree'.setup() end,
    cmd = 'NvimTreeToggle',
  },
  -- Webページ内のテキストボックスを編集するために外部のテキストエディタを使用できるようにするブラウザアドオンGhostTextに対応するためのプラグイン
  -- Neovim側がサーバーとして動作する
  -- GhostTextを利用するためにはneovimを予め立ち上げ、:GhostTextStartでサーバーを起動させておく必要がある
  -- GhostTextとneovimはlocalhost:4001で通信する
  {
    'subnut/nvim-ghost.nvim',
    init = function()
      vim.g.nvim_ghost_autostart = 0
    end,
    cmd = 'GhostTextStart'
  },
}
