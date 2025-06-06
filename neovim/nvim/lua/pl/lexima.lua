local M = {}

function M.init()
  vim.g.lexima_enable_basic_rules = 1
  vim.g.lexima_enable_newline_rules = 1
  vim.g.lexima_enable_endwise_rules = 1
end

function M.config()
  vim.cmd "call lexima#add_rule({'filetype': [ 'tex', 'plaintex' ], 'char': '$', 'input_after': '$'})"
  vim.cmd "call lexima#add_rule({'filetype': [ 'tex', 'plaintex' ], 'char': '$', 'at': '\\%#\\$', 'leave': 1})"
  vim.cmd "call lexima#add_rule({'filetype': [ 'tex', 'plaintex' ], 'char': '<BS>', 'at': '\\$\\%#\\$', 'delete': 1})"
  vim.cmd "call lexima#add_rule({'filetype': 'markdown', 'char': '<Space>', 'at': '\\[\\%#]'})"
end

return M
