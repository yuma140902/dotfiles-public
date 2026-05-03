---@type LazySpec
return {
  'https://github.com/numToStr/FTerm.nvim',
  cond = not vim.g.vscode,

  init = function()
    local map = require 'rc.keymaps'.map
    map.n '<space>tf' {
      desc = 'floating windowのターミナルをトグル',
      function()
        require 'FTerm'.toggle()
      end
    }
    map.nt '<A-d>' {
      desc = 'floating windowのターミナルをトグル',
      function()
        require 'FTerm'.toggle()
      end
    }
  end,

  config = function()
    local cmd
    if vim.fn.has('win32') == 1 then
      if vim.fn.executable('pwsh') == 1 then
        cmd = 'pwsh'
      else
        cmd = 'powershell'
      end
    else
      cmd = os.getenv('SHELL')
    end
    require 'FTerm'.setup {
      border = 'rounded',
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
      cmd = cmd,
    }
  end
}
