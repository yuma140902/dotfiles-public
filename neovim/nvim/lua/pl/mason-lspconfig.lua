local M = {}

function M.config()
  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

  local group = vim.api.nvim_create_augroup('format_on_save', { clear = true })

  local do_format = function(bufnr)
    -- no_formatがセットされているならフォーマットしない
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

  -- LSPサーバにアタッチされたときに呼ばれる
  local on_attach = function(client, bufnr)
    -- :h lspconfig-keybindings
    -- :h vim.lsp.*

    -- [Avoiding LSP formatting conflicts · nvimtools/none-ls.nvim Wiki](https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts)
    -- 保存時にフォーマットする
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
          do_format(bufnr)
        end,
      })
    end
  end


  require 'mason-lspconfig'.setup {
    ensure_installed = {},
    handlers = {
      function(server_name)
        require 'lspconfig'[server_name].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end,
      ['rust_analyzer'] = function()
        -- なにもしない
        -- rust-analyzerのセットアップはmason-lspconfigではなくrustaceanvimが行う
      end,
      ['lua_ls'] = function()
        require 'lspconfig'.lua_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        }
      end,
      ['denols'] = function()
        require 'lspconfig'.denols.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = require 'lspconfig'.util.root_pattern('deno.json', 'deno.jsonc'),
          single_file_support = false,
        }
      end,
      ['tsserver'] = function()
        require 'lspconfig'.tsserver.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = require 'lspconfig'.util.root_pattern('package.json'),
          single_file_support = false,
        }
      end,
    },
  }
end

return M
