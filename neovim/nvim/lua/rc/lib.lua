-- 他の(複数の)場所から使われる可能性のある関数

local M = {}

function M.map(mode, key, cmd, desc, opt)
  if opt == nil then opt = {} end
  if opt['noremap'] == nil then opt['noremap'] = true end
  if opt['silent'] == nil then opt['silent'] = true end

  if desc ~= nil then
    if opt['desc'] == nil then
      opt['desc'] = desc
    else
      print('warn: desc argument will be ignored')
    end
  end

  vim.keymap.set(mode, key, cmd, opt)
end

return M
