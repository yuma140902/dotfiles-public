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

-- 特定のfiletypeを持つバッファを閉じる
function M.close_buffers_by_filetype(filetype)
  local target_buffers = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(bufnr, 'filetype') == filetype then
      table.insert(target_buffers, bufnr)
    end
  end

  if #target_buffers ~= 0 then
    for _, bufnr in ipairs(target_buffers) do
      vim.api.nvim_buf_delete(bufnr, { force = true, unload = true })
    end
  end
end

return M
