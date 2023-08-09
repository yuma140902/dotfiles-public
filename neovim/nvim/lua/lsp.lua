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


    require 'lsp_signature'.on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
      },
      extra_trigger_chars = { "(", "," },
      always_trigger = false,

      floating_window_above_cur_line = false,
      floating_window_off_x = 1,                         -- adjust float windows x position.
      floating_window_off_y = function()                 -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
        local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline()                 -- line number in the window
        local winheight = vim.fn.winheight(0)

        local margin = 3

        -- window top
        if winline - 1 < pumheight + margin then
          return pumheight + margin
        end

        -- window bottom
        if winheight - winline < pumheight + margin then
          return -pumheight - margin
        end

        return 0
      end,
    }, bufnr)
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
    ['rust_analyzer'] = function()
      require 'rust-tools'.setup {
        capabilities = capabilities,
        server = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- Hover actions
            -- 代わりにlspsagaを使う
            -- vim.keymap.set('n', '<C-space>', require'rust-tools'.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            -- 代わりにlspsagaを使う
            -- vim.keymap.set('n', '<space>a', require'rust-tools'.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
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
