---@type LazySpec
return {
  'https://github.com/lewis6991/gitsigns.nvim',
  cond = not vim.g.vscode,
  event = { 'User UIEnterPost' },
  cmd = { 'Gitsigns' },

  init = function()
    local map = require 'rc.keymaps'.map
    require 'which-key'.add {
      { '<space>h', group = 'gitsigns' },
      { '<space>ht', group = 'トグル' },
    }
    -- Navigation
    map.n ']h' {
      desc = '次のHunkへ',
      function()
        if vim.wo.diff then return ']h' end
        vim.schedule(function() require 'gitsigns'.nav_hunk('next') end)
        return '<Ignore>'
      end,
      expr = true,
    }
    map.n '[h' {
      desc = '前のHunkへ',
      function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() require 'gitsigns'.nav_hunk('prev') end)
        return '<Ignore>'
      end,
      expr = true
    }
    -- Actions
    map.n '<space>hh' {
      desc = 'Gitsignsを読み込む',
      function()
        require 'gitsigns'
        vim.notify('Gitsigns Loaded', vim.log.levels.INFO, {
          title = 'Plugin Loading'
        })
      end,
    }
    map.n '<space>hs' { function() require 'gitsigns'.stage_hunk() end, desc = 'Hunkをステージ' }
    map.n '<space>hr' { function() require 'gitsigns'.reset_hunk() end, desc = 'Hunkをリセット' }
    map.x '<space>hs' {
      desc = '選択範囲をステージ',
      function()
        require 'gitsigns'.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
      end,
    }
    map.x '<space>hr' {
      desc = '選択範囲をリセット',
      function()
        require 'gitsigns'.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
      end
    }
    map.n '<space>hS' { function() require 'gitsigns'.stage_buffer() end, desc = 'バッファ全体をステージ' }
    map.n '<space>hu' { function() require 'gitsigns'.undo_stage_hunk() end, desc = 'ステージを取り消す' }
    map.n '<space>hR' { function() require 'gitsigns'.reset_buffer() end, desc = 'バッファ全体をリセット' }
    map.n '<space>hP' { function() require 'gitsigns'.preview_hunk() end, desc = 'Hunkをプレビュー(ポップアップ)' }
    map.n '<space>hp' { function() require 'gitsigns'.preview_hunk_inline() end, desc = 'Hunkをプレビュー' }
    map.n '<space>hb' { function() require 'gitsigns'.blame_line { full = true } end, desc = 'この行をblame' }
    map.n '<space>htb' { function() require 'gitsigns'.toggle_current_line_blame() end, desc = '行blameをトグル' }
    map.n '<space>hd' { function() require 'gitsigns'.diffthis() end, desc = 'vimdiff(diffthis)(????)' }
    map.n '<space>hD' { function() require 'gitsigns'.diffthis('~') end }
    map.n '<space>htd' { function() require 'gitsigns'.toggle_deleted() end, desc = 'Toggle Deleted' }
    map.n '<space>lh' { function() require 'gitsigns'.setqflist('all') end, desc = '未ステージのHunkの一覧' }
    -- Text object
    map.xo 'ih' { ':<C-U>Gitsigns select_hunk<CR>', desc = 'Hunk (Gitsigns)' }
  end,

  config = function()
    require 'gitsigns'.setup {
      trouble = true,
    }
  end
}
