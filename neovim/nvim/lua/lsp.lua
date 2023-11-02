local function setup_lsp()
  require 'mason'.setup()
  local mason_lspconfig = require 'mason-lspconfig'
  local lspconfig = require 'lspconfig'
  mason_lspconfig.setup {
    ensure_installed = {}
  }

  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

  local on_attach = function(client, bufnr)
    -- :h lspconfig-keybindings
    -- :h vim.lsp.*
    --
  end

  -- 保存時にLSPの機能を使ってフォーマットする
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('format_on_save', { clear = true }),
    pattern = '*',
    callback = function()
      if not vim.b.no_format_on_save then
        vim.lsp.buf.format { async = false }
      end
    end
  })

  -- 一部のfiletypeでは保存時の自動フォーマットを行わない
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('disable_format_on_save', { clear = true }),
    -- filetypeをカンマ区切りで指定する
    -- filetypeはバッファを開いた状態で:set ftで確認できる
    -- tex: texlabのバグ？により、フォーマットするたびにファイル末尾に改行が追加されてしまうので解消されるまで無効化 TODO:
    pattern = 'tex',
    callback = function()
      vim.b.no_format_on_save = true
    end
  })

  -- :h mason-lspconfig-automatic-server-setup
  mason_lspconfig.setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    ['lua_ls'] = function()
      lspconfig.lua_ls.setup {
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
      lspconfig.denols.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
        single_file_support = false,
      }
    end,
    ['tsserver'] = function()
      lspconfig.tsserver.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('package.json'),
        single_file_support = false,
      }
    end,
  }
end

return {
  setup_lsp = setup_lsp
}
