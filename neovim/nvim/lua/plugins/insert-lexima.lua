---@type LazySpec
return {
  -- 閉じカッコなどの自動入力
  'https://github.com/cohama/lexima.vim',
  event = 'InsertEnter',

  init = function()
    vim.g.lexima_enable_basic_rules = 1
    vim.g.lexima_enable_newline_rules = 1
    vim.g.lexima_enable_space_rules = 1
    vim.g.lexima_enable_endwise_rules = 1

    -- Telescope で lexima を無効化する
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('disable-lexima-on-telescope', { clear = true }),
      pattern = 'TelescopePrompt',
      callback = function()
        vim.b.lexima_disabled = 1
      end,
    })
  end,

  config = function()
    vim.fn['lexima#add_rule'] { filetype = { 'tex', 'plaintex' }, char = '$', input_after = '$' }
    vim.fn['lexima#add_rule'] { filetype = { 'tex', 'plaintex' }, char = '$', at = '\\%#\\$', leave = 1 }
    vim.fn['lexima#add_rule'] { filetype = { 'tex', 'plaintex' }, char = '<BS>', at = '\\$\\%#\\$', delete = 1 }
    vim.fn['lexima#add_rule'] { filetype = 'markdown', char = '<Space>', at = '\\[\\%#]' }

    -- Lisp 系では parinfer を使うので '('、'{'、'[' を実質的に無効化する
    -- この無効化の方法は lexima 内部の basic rules でも使用されている
    -- Rust 等でシングルクォートを無効化する例:
    -- https://github.com/cohama/lexima.vim/blob/ab621e4756465c9d354fce88cff2bd1aa7887065/autoload/lexima.vim#L69
    -- {'char': "'", 'filetype': ['haskell', 'lisp', 'clojure', 'ocaml', 'reason', 'scala', 'rust']}
    vim.fn['lexima#add_rule'] { filetype = { 'lisp', 'clojure' }, char = '(' }
    vim.fn['lexima#add_rule'] { filetype = { 'lisp', 'clojure' }, char = '[' }
    vim.fn['lexima#add_rule'] { filetype = { 'lisp', 'clojure' }, char = '{' }
  end
}
