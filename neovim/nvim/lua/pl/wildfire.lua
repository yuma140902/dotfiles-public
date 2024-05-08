local M = {}

function M.config()
  require 'wildfire'.setup {
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
    },
  }
end

return M
