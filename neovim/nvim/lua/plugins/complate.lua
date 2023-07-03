-- 自動補完に関するプラグイン
return {
  {
    -- vim-vsnip
    'hrsh7th/vim-vsnip',
    dependencies = {
      { 'hrsh7th/vim-vsnip-integ',      lazy = true },
      { 'rafamadriz/friendly-snippets', lazy = true },
    },
    event = { 'InsertEnter', 'CmdlineEnter' }
  },

  {
    -- nvim-cmp
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- バッファ内の単語。普通フォールバック先として使う。ddc.vimのaroundソースに相当
      { 'hrsh7th/cmp-buffer',                  lazy = true },
      -- vsnipからの候補
      { 'hrsh7th/cmp-vsnip',                   lazy = true },
      -- lspからの候補
      { 'hrsh7th/cmp-nvim-lsp',                lazy = true },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true },
      -- ファイルパスの補完ソース
      { 'hrsh7th/cmp-path',                    lazy = true },
      -- コマンドラインでの補完ソース
      { 'hrsh7th/cmp-cmdline',                 lazy = true },
      {
        -- cmp-nvim-lsp-signature-helpのかわり。試用中
        'ray-x/lsp_signature.nvim',
        lazy = true
      }
    },
    init = function()
      vim.cmd 'set completeopt=menu,menuone,noselect'
    end,
    config = function()
      local cmp = require 'cmp'

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
            vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match(
              '%s') ==
            nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode,
          true)
      end

      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        window = {
          --completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item { behavior = cmp.SelectBehavior
                  .Select }
            elseif has_words_before() then
              cmp.confirm { select = false }
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior
                  .Select }
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
              feedkey('<Plug>(vsnip-jump-prev)', '')
            end
          end, { 'i', 's' }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<C-e>'] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          --{ name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
          { name = 'path' },
        }, {
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
              keyword_length = 3
            }
          },
        })
      }

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline', keyword_length = 3 }
        })
      })
    end,
    event = { 'InsertEnter', 'CmdlineEnter' }
  },
}
