local M = {}

---@param name string
---@param command any
---@param opt vim.api.keyset.user_command
function M.command(name, command, opt)
  if opt == nil then opt = {} end
  vim.api.nvim_create_user_command(name, command, opt)
end

---特定のfiletypeを持つバッファを閉じる
---@param filetype string
function M.close_buffers_by_filetype(filetype)
  local target_buffers = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == filetype then
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
