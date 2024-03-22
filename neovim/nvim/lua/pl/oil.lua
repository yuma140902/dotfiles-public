local M = {}

function M.config()
  require 'oil'.setup {
    default_file_explorer = false,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    constrain_cursor = 'editable',
    experimental_watch_for_changes = false,

    columns = {
      'icon',
      -- 'permissions',
      -- 'size',
      -- 'mtime',
    },

    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },

    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },
    restore_win_options = true,

    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = false,
      ['R'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['g.'] = 'actions.toggle_hidden',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g\\'] = 'actions.toggle_trash',
    },
    use_default_keymaps = true,

    view_options = {
      show_hidden = false,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, '.') or name == 'node_modules' or name == 'target' or name == '__pycache__'
      end,
      is_always_hidden = function(name, bufnr)
        return name == '.git'
      end,
      -- :help oil-columns
      sort = {
        { 'type', 'asc' },
        { 'name', 'asc' }
      }
    },

    lsp_file_methods = {
      timeout_ms = 1000,
      autosave_changes = 'unmodified',
    },

    float = {},
    -- Configuration for the actions floating preview window
    preview = {},
    -- Configuration for the floating progress window
    progress = {},

    ssh = {},
  }

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'PersistedSavePre',
    callback = function()
      require 'rc.lib'.close_buffers_by_filetype('oil')
    end
  })
end

return M
