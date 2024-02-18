local M = {}

function M.init()
  vim.g.ambiwidth_add_list = {
    { 0xe640,  0xe640,  2 },
    { 0xf073a, 0xf073a, 2 }
  }
end

return M
