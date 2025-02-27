-- 特定の言語固有のプラグイン

---@type LazySpec
return {
  {
    -- schemastore.orgが提供しているJSONの様々なスキーマを読み込む
    'b0o/schemastore.nvim',
    -- mason-lspconfigがjsonlsの設定をするときに読み込まれる
    lazy = true,
  },

  {
    -- lua_lsに対してNeovimのLua APIや読み込まれているプラグインのドキュメント・型を提供する
    'folke/neodev.nvim',
    ft = 'lua',
  },

  {
    -- pest-parser の syntax highlight
    'pest-parser/pest.vim',
    ft = 'pest'
  },

  {
    -- Rust Analyzerの機能をコマンドで呼び出すためのプラグイン
    'vxpm/ferris.nvim',
    config = require 'pl.ferris'.config,
    cmd = {
      "FerrisExpandMacro",
      "FerrisJoinLines",
      "FerrisViewHIR",
      "FerrisViewMIR",
      "FerrisViewMemoryLayout",
      "FerrisViewSyntaxTree",
      "FerrisViewItemTree",
      "FerrisOpenCargoToml",
      "FerrisOpenParentModule",
      "FerrisOpenDocumentation",
      "FerrisReloadWorkspace",
      "FerrisRebuildMacros",
    }
  },

  {
    -- Rustに関する機能を追加する
    -- rust-analyzerのインストールについて:
    -- rust-analyzerのインストールはrustup、masonどちらで行なっても良い
    'mrcjkb/rustaceanvim',
    lazy = true,
    init = require 'pl.rustaceanvim'.init,
    ft = 'rust'
  },

  {
    -- クレートの情報を見たりアップデートしたりする
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "BufRead Cargo.toml" },
    config = require 'pl.crates'.config,
  },

  {
    -- 対応するカッコをネストの深さに応じて色分けする
    -- Lispのときだけ使用する
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    ft = "lisp"
  },

}
