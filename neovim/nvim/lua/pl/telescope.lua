local M = {}

function M.config()
  require 'telescope'.setup {
    defaults = { file_ignore_patterns = { '.git/*' } },
    extensions = {
      undo = {
        side_by_side = true,
        layout_strategy = 'vertical',
        layout_config = {
          preview_height = 0.8
        }
      }
    },
    pickers = {
      buffers = {
        mappings = {
          i = {
            ['<esc>'] = require 'telescope.actions'.close,
            ['<C-k>'] = require 'telescope.actions'.delete_buffer,
          },
          n = {
            ['<C-f>'] = require 'telescope.actions'.close,
            ['<C-k>'] = require 'telescope.actions'.delete_buffer,
          }
        }
      }
    }
  }
  require 'telescope'.load_extension 'gh'
  require 'telescope'.load_extension 'notify'
  require 'telescope'.load_extension 'undo'
end

return M
