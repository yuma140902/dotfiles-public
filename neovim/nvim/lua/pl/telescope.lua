local M = {}

function M.config()
  require 'telescope'.setup {
    defaults = { file_ignore_patterns = {} },
    extensions = {
      command_palette = require 'command_palette'.table,
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
            ['<esc>'] = require 'telescope.actions'.close
          },
          n = {
            ['<C-f>'] = require 'telescope.actions'.close
          }
        }
      }
    }
  }
  require 'telescope'.load_extension 'command_palette'
  require 'telescope'.load_extension 'gh'
  require 'telescope'.load_extension 'notify'
  require 'telescope'.load_extension 'undo'
end

return M
