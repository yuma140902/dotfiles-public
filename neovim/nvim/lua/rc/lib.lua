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

function M.command(name, command, opt)
  if opt == nil then opt = {} end
  vim.api.nvim_create_user_command(name, command, opt)
end

function M.default_winblend()
  if vim.g.neovide then
    return 90
  else
    -- onedark.lua で transparent = true とするときは 0、そうでないときは 20 が良い
    -- return 20
    return 0
  end
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

---バッファをフォーマットする
---@param bufnr number
function M.do_format(bufnr)
  -- b:no_formatがセットされているならフォーマットしない
  -- :let b:no_format = 1
  if vim.b[bufnr].no_format or vim.b[bufnr].no_format == 1 then
    return
  end

  -- bufnrをもとにどのようにフォーマットするか決める
  -- 今のところはいつもLSPを使う
  vim.lsp.buf.format({
    filter = function(client_)
      -- bufnrとclient_をもとに、各LSPサーバでフォーマットを行うかどうか決定する
      -- 今のところはいつもtrueを返す。つまりアタッチされているすべてのLSPサーバでフォーマットを行う
      return true
    end,
    bufnr = bufnr,
  })
end

-- 保存時に自動保存するautocmdのグループ
M.auto_format_augroup = vim.api.nvim_create_augroup('auto_format', { clear = true })

---LSPクライアントがアタッチされたときに呼ばれる
---@param client lsp.Client
---@param bufnr number
function M.on_attach(client, bufnr)
  -- :h lspconfig-keybindings
  -- :h vim.lsp.*

  -- [Avoiding LSP formatting conflicts · nvimtools/none-ls.nvim Wiki](https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts)
  -- 保存時にフォーマットする
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = M.auto_format_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = M.auto_format_augroup,
      buffer = bufnr,
      callback = function()
        M.do_format(bufnr)
      end,
    })
  end
end

return M
