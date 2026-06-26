---@type LazySpec
return {
  -- ファイルマネージャー
  'https://github.com/stevearc/oil.nvim',
  cond = not vim.g.vscode,
  dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
  cmd = { 'Oil' },

  init = function()
    local map = require 'rc.keymaps'.map
    map.n '-' { '<cmd>Oil<CR>', desc = 'ディレクトリに移動' }
  end,

  config = function()
    ---@param input string
    local function shell(input)
      local cmd = { 'sh', '-c', input } -- TODO: win32
      vim.system(cmd, { text = true }, function(job)
        vim.schedule(function()
          if job.code == 0 then
            print(job.stdout)
          else
            print(("code: %d, stderr: %s"):format(job.code, job.stderr))
          end
        end)
      end)
    end

    local last_cmd = ""

    local detail_view = false

    require 'oil'.setup {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      constrain_cursor = 'editable',
      experimental_watch_for_changes = false,

      columns = {
        'icon',
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
        ['ge'] = {
          desc = 'Execute shell command on oil.nvim entry',
          callback = function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()

            if entry and dir then
              local full_path = vim.fn.shellescape(dir .. entry.name)

              vim.ui.input({ prompt = 'Shell command: ', default = last_cmd }, function(input)
                if not input or input == '' then
                  return
                end
                last_cmd = input
                shell(input .. ' ' .. full_path)
              end)
            else
              print('No entry selected')
            end
          end
        },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail_view = not detail_view
            if detail_view then
              require 'oil'.set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require 'oil'.set_columns { 'icon' }
            end
          end
        }
      },
      use_default_keymaps = true,

      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _bufnr)
          return vim.startswith(name, '.') or name == 'node_modules' or name == 'target' or name == '__pycache__'
        end,
        is_always_hidden = function(name, _bufnr)
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
        require 'rc.util'.close_buffers_by_filetype('oil')
      end
    })
  end
}
