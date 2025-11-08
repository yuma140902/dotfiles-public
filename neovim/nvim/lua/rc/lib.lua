-- 他の(複数の)場所から使われる可能性のある関数

local M = {}

---@alias rc.IconCat "LSP"|"LspUI"
---@type table<rc.IconCat, wk.Icon>
local IconCatTable = {
  LSP = { icon = "", color = "purple" },
  LspUI = { icon = "", color = "orange" },
}

---@class mapset_opts: vim.keymap.set.Opts
---@field icon? rc.IconCat|wk.Icon

-- reference: https://zenn.dev/monaqa/articles/2025-07-23-vim-keymap-set-dsl

---@param mode string|string[]
---@param is_buffer_local? boolean
---@return fun(lhs: string): fun(opts: mapset_opts): nil
local function map_(mode, is_buffer_local)
  ---@param lhs string
  ---@return fun(vim.keymap.set.Opts): nil
  return function(lhs)
    ---@param opts mapset_opts
    return function(opts)
      local body = opts[1]
      local icon = opts['icon']
      opts[1] = nil
      opts['icon'] = nil
      if opts['buffer'] == nil then
        opts['buffer'] = is_buffer_local
      end
      if opts['desc'] ~= nil and type(icon) == 'string' then
        opts['desc'] = '[' .. icon .. ']' .. opts['desc']
      end
      if type(icon) == 'string' then
        icon = IconCatTable[icon]
      end
      vim.keymap.set(mode, lhs, body, opts)
      require 'which-key'.add {
        mode = mode,
        { lhs, icon = icon }
      }
    end
  end
end

M.map = {
  --- NORMAL mode のキーマップを定義する。
  n = map_ 'n',
  --- VISUAL mode のキーマップを定義する。
  x = map_ 'x',
  --- OPERATOR-PENDING mode のキーマップを定義する。
  o = map_ 'o',
  --- INSERT mode のキーマップを定義する。
  i = map_ 'i',
  --- COMMAND-LINE mode のキーマップを定義する。
  c = map_ 'c',
  --- SELECT mode のキーマップを定義する。
  s = map_ 'x',
  --- TERMINAL mode のキーマップを定義する。
  t = map_ 't',

  --- NORMAL / VISUAL キーマップ（オペレータ/モーションなど）
  nx = map_ { 'n', 'x' },
  --- VISUAL / SELECT キーマップ（制御文字を用いた VISUAL キーマップなど）
  xs = map_ { 'x', 's' },
  --- VISUAL / OPERATOR-PENDING キーマップ（モーション、text object など）
  xo = map_ { 'x', 'o' },
  --- NORMAL / TERMINAL キーマップ（ターミナルの制御など）
  nt = map_ { 'n', 't' },

  --- NORMAL-like mode のキーマップ（モーションなど）
  nxo = map_ { 'n', 'x', 'o' },
  --- INSERT-like mode のキーマップ（文字入力など）
  ic = map_ { 'i', 'c' },

  --- iabbrev を定義する。
  ia = map_ 'ia',
  --- cabbrev を定義する。
  ca = map_ 'ca',

  --- モードを文字列で指定してキーマップを定義する。
  with_mode = map_,
}

M.map_local = {
  --- NORMAL mode の buffer-local キーマップを定義する。
  n = map_('n', true),
  --- VISUAL mode の buffer-local キーマップを定義する。
  x = map_('x', true),
  --- OPERATOR-PENDING mode の buffer-local キーマップを定義する。
  o = map_('o', true),
  --- INSERT mode の buffer-local キーマップを定義する。
  i = map_('i', true),
  --- COMMAND-LINE mode の buffer-local キーマップを定義する。
  c = map_('c', true),
  --- SELECT mode の buffer-local キーマップを定義する。
  s = map_('s', true),
  --- TERMINAL mode の buffer-local キーマップを定義する。
  t = map_('t', true),

  --- NORMAL / VISUAL の buffer-local キーマップ。
  nx = map_({ 'n', 'x' }, true),
  --- VISUAL / SELECT の buffer-local キーマップ。
  xs = map_({ 'x', 's' }, true),
  --- VISUAL / OPERATOR-PENDING の buffer-local キーマップ。
  xo = map_({ 'x', 'o' }, true),

  --- NORMAL-like モードの buffer-local キーマップ。
  nxo = map_({ 'n', 'x', 'o' }, true),
  --- INSERT-like モードの buffer-local キーマップ。
  ic = map_({ 'i', 'c' }, true),

  --- buffer-local iabbrev を定義する。
  ia = map_('ia', true),
  --- buffer-local cabbrev を定義する。
  ca = map_('ca', true),
}

---@param name string
---@param command any
---@param opt table<string, any>?
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
