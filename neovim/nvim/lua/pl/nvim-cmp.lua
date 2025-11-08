local M = {}

function M.init()
  vim.cmd 'set completeopt=menu,menuone,noselect'
end

function M.config()
  local cmp = require 'cmp'

  --[[  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match(
          '%s') ==
        nil
  end
  ]]

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode,
      true)
  end

  -- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#tab-completion-configuration-highly-recommended
  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  end

  local cmp_kinds = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
    Copilot = '󰚩 ',
  }

  local source_names = {
    buffer = '[BUF]',
    copilot = '[COPILOT]',
    nvim_lsp = '[LSP]',
    vsnip = '[VSNIP]',
    nvim_lua = '[LUA]',
    path = '[PATH]',
    cmdline = '[CMD]',
    cmdline_history = '[HIST]',
    conventionalcommits = '[CONV]',
    nvim_lsp_document_symbol = '[LSP_SYM]',
  }

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
      completion = {
        border = 'none',
        winhighlight = vim.g.neovide and 'Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:MyNvimCmpSel,Search:None' or 'Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None'
      }
    },
    view = {
      docs = { auto_open = true },
      entries = { name = 'custom', selection_order = 'near_cursor' },
    },
    formatting = {
      expandable_indicator = true,
      fields = { 'abbr', 'kind', 'menu' }, -- :h completion-itemsを参照
      format = function(entry, vim_item)
        -- fun(entry: cmp.Entry, vim_item: vim.CompletedItem): vim.CompletedItem
        if vim_item.kind == nil then
          vim_item.kind = ''
        end
        local kind_icon = cmp_kinds[vim_item.kind]
        if kind_icon == nil then
          vim_item.kind = '   ' .. '   ' .. vim_item.kind
        else
          vim_item.kind = '   ' .. kind_icon .. ' ' .. vim_item.kind
        end

        local source_name = source_names[entry.source.name]
        if source_name ~= nil then
          vim_item.menu = source_name
        else
          vim_item.menu = '[' .. entry.source.name .. ']'
        end
        return vim_item
      end
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        -- compare.scopes,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        -- compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
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
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = "copilot" },
      { name = 'vsnip' },
      { name = 'path' },
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

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'conventionalcommits' },
      { name = "copilot" },
      { name = 'vsnip' },
      { name = 'path' },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      }
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol', keyword_length = 3 },
      { name = 'cmdline_history',          keyword_length = 3 },
      { name = 'buffer' }
    })
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
      { name = 'cmdline',         keyword_length = 3 },
      { name = 'cmdline_history', keyword_length = 3 }
    })
  })
end

return M
