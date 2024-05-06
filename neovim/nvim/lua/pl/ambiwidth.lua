local M = {}

function M.init()
  vim.g.ambiwidth_add_list = {
    { 0xe640,  0xe640,  2 },
    { 0xea7b,  0xea83,  2 },
    { 0xea88,  0xea96,  2 },
    { 0xeb5b,  0xeb66,  2 },
    { 0xf073a, 0xf073a, 2 },
  }
end

return M
