---@type LazySpec
return {
  'https://github.com/julienvincent/nvim-paredit',
  ft = { 'lisp', 'clojure' },
  config = function()
    require 'nvim-paredit'.setup()
  end
}
