---@type LazySpec
return {
  -- クレートの情報を見たりアップデートしたりする
  'https://github.com/saecki/crates.nvim',
  cond = not vim.g.vscode,
  dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
  event = { 'BufRead Cargo.toml' },
  config = function()
    require 'crates'.setup {
      completion = {
        crates = {
          enabled = true,  -- disabled by default
          max_results = 8, -- The maximum number of search results to display
          min_chars = 3,   -- The minimum number of characters to type before completions begin appearing
        }
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      }
    }

    -- キーマップの追加
    local crates = require 'crates'
    local map = require 'rc.keymaps'.map

    require 'which-key'.add { '<space>c', group = 'crates.nvim' }

    map.n '<space>ct' { crates.toggle, desc = 'Toggle' }
    map.n '<space>cr' { crates.reload, desc = 'Reload' }

    map.n '<space>cv' { crates.show_versions_popup, desc = 'Show versions popup' }
    map.n '<space>cf' { crates.show_features_popup, desc = 'Show features popup' }
    map.n '<space>cd' { crates.show_dependencies_popup, desc = 'Show dependencies popup' }

    map.n '<space>cu' { crates.update_crate, desc = 'Update crate' }
    map.x '<space>cu' { crates.update_crates, desc = 'Update crates' }
    map.n '<space>ca' { crates.update_all_crates, desc = 'Update ALL crates' }
    map.n '<space>cU' { crates.upgrade_crate, desc = 'Upgrade crate' }
    map.x '<space>cU' { crates.upgrade_crates, desc = 'Upgrade crates' }
    map.n '<space>cA' { crates.upgrade_all_crates, desc = 'Upgrade ALL crates' }

    --vim.keymap.set('n', '<space>ce', crates.expand_p desc =lain_crate_to_inline_table, {silent = true})
    --vim.keymap.set('n', '<space>cE', crates.extract_crate_into_table, {silent = true})

    map.n '<space>cH' { crates.open_homepage, desc = 'Open homepage' }
    map.n '<space>cR' { crates.open_repository, desc = 'Open repo' }
    map.n '<space>cD' { crates.open_documentation, desc = 'Open doc' }
    map.n '<space>cC' { crates.open_crates_io, desc = 'Open crates.io' }
  end
}
