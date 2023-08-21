local M = {}

function M.init()
  vim.g.lexima_enable_basic_rules = 1
  vim.g.lexima_enable_newline_rules = 1
  vim.g.lexima_enable_endwise_rules = 1
end

function M.config()
  vim.cmd "call lexima#add_rule({'filetype': 'rust', 'char': '''', 'at': '&\\%#', 'input': ''''})"
  vim.cmd "call lexima#add_rule({'filetype': 'latex', 'char': '$', 'input_after': '$'})"
  vim.cmd "call lexima#add_rule({'filetype': 'latex', 'char': '$', 'at': '\\%#\\$', 'leave': 1})"
  vim.cmd "call lexima#add_rule({'filetype': 'latex', 'char': '<BS>', 'at': '\\$\\%#\\$', 'delete': 1})"
end

return M
