-- 他の(複数の)場所から使われる可能性のある関数

local M = {}

---@param mode string|string[]
---@param key string
---@param cmd string|function
---@param desc? string
---@param opt? vim.keymap.set.Opts
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

---@param name string
---@param command any
---@param opt table<string, any>
function M.command(name, command, opt)
  if opt == nil then opt = {} end
  vim.api.nvim_create_user_command(name, command, opt)
end

---@return integer
function M.default_winblend()
  if vim.g.neovide then
    return 90
  else
    -- onedark.lua で transparent = true とするときは 0、そうでないときは 20 が良い
    -- return 20
    return 0
  end
end

---特定のfiletypeを持つバッファを閉じる
---@param filetype string
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

---LSPクライアントがアタッチされたときに呼ばれる
---@param _client vim.lsp.Client
---@param _bufnr number
function M.on_attach(_client, _bufnr)

end

return M
