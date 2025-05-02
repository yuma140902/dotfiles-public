local M = {}

function M.config()
  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
  local on_attach = require 'rc.lib'.on_attach

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
        require 'pl.neodev'.config()
        require 'lspconfig'.lua_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              },
              hint = {
                enable = true
              }
            }
          }
        }
      end,
      ['clangd'] = function()
        capabilities.offsetEncoding = "utf-8"
        capabilities.offset_encoding = "utf-8"
        capabilities.clang = {}
        capabilities.clang.offsetEncoding = "utf-8"
        capabilities.clang.offset_encoding = "utf-8"

        require 'lspconfig'.clangd.setup {
          on_attach = on_attach,
          capabilities = capabilities,
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
      ['ts_ls'] = function()
        require 'lspconfig'.ts_ls.setup {
          -- TODO: prettierを使いたい場合、on_attach内でcapabilityを変更してLSPのフォーマッタを無効化する
          -- see: https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = require 'lspconfig'.util.root_pattern('package.json'),
          single_file_support = false,
        }
      end,
      ['jsonls'] = function()
        require 'lspconfig'.jsonls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            json = {
              schemas = require 'schemastore'.json.schemas(),
              validate = { enable = true },
            }
          }
        }
      end,
    },
  }
end

return M
