local M = {}

function M.config()
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
      on_attach = require 'rc.lib'.on_attach,
      actions = true,
      completion = true,
      hover = true,
    }
  }

  -- キーマップの追加
  local crates = require 'crates'
  local map_local = require 'rc.lib'.map_local

  map_local.n '<space>ct' { crates.toggle, desc = 'Toggle' }
  map_local.n '<space>cr' { crates.reload, desc = 'Reload' }

  map_local.n '<space>cv' { crates.show_versions_popup, desc = 'Show versions popup' }
  map_local.n '<space>cf' { crates.show_features_popup, desc = 'Show features popup' }
  map_local.n '<space>cd' { crates.show_dependencies_popup, desc = 'Show dependencies popup' }

  map_local.n '<space>cu' { crates.update_crate, desc = 'Update crate' }
  map_local.x '<space>cu' { crates.update_crates, desc = 'Update crates' }
  map_local.n '<space>ca' { crates.update_all_crates, desc = 'Update ALL crates' }
  map_local.n '<space>cU' { crates.upgrade_crate, desc = 'Upgrade crate' }
  map_local.x '<space>cU' { crates.upgrade_crates, desc = 'Upgrade crates' }
  map_local.n '<space>cA' { crates.upgrade_all_crates, desc = 'Upgrade ALL crates' }

  --vim.keymap.set('n', '<space>ce', crates.expand_p desc =lain_crate_to_inline_table, {silent = true})
  --vim.keymap.set('n', '<space>cE', crates.extract_crate_into_table, {silent = true})

  map_local.n '<space>cH' { crates.open_homepage, desc = 'Open homepage' }
  map_local.n '<space>cR' { crates.open_repository, desc = 'Open repo' }
  map_local.n '<space>cD' { crates.open_documentation, desc = 'Open doc' }
  map_local.n '<space>cC' { crates.open_crates_io, desc = 'Open crates.io' }
end

return M
