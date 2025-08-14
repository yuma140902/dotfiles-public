-- 他の(複数の)場所から使われる可能性のある関数

local M = {}

---@alias rc.IconCat "LSP"|"Lspsaga"
---@type table<rc.IconCat, wk.Icon>
local IconCatTable = {
  LSP = { icon = "", color = "purple" },
  Lspsaga = { icon = "", color = "orange" },
}

---@param mode string|string[]
---@param key string
---@param cmd string|function
---@param desc? string
---@param opt? vim.keymap.set.Opts
---@param icon? rc.IconCat|wk.Icon
function M.map(mode, key, cmd, desc, opt, icon)
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

  if opt['desc'] ~= nil and type(icon) == "string" then
    opt['desc'] = '[' .. icon .. '] ' .. opt['desc']
  end

  if type(icon) == "string" then
    icon = IconCatTable[icon]
  end

  vim.keymap.set(mode, key, cmd, opt)
  require 'which-key'.add({
    mode = mode,
    { key, icon = icon }
  })
end

---@param name string
---@param command any
---@param opt table<string, any>
function M.command(name, command, opt)
  if opt == nil then opt = {} end
  vim.api.nvim_create_user_command(name, command, opt)
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
