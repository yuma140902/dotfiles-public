local M = {}

function M.config()
  require 'crates'.setup {
    src = {
      cmp = {
        enabled = true,
      },
    },
    lsp = {
      enabled = true,
    }
  }

  -- nvim-cmpソースの追加
  vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
      require 'cmp'.setup.buffer({ sources = { { name = "crates" } } })
    end,
  })

  -- キーマップの追加
  local crates = require 'crates'
  local map = require 'rc.lib'.map

  map('n', '<space>ct', crates.toggle, 'Toggle')
  map('n', '<space>cr', crates.reload, 'Reload')

  map('n', '<space>cv', crates.show_versions_popup, 'Show versions popup')
  map('n', '<space>cf', crates.show_features_popup, 'Show features popup')
  map('n', '<space>cd', crates.show_dependencies_popup, 'Show dependencies popup')

  map('n', '<space>cu', crates.update_crate, 'Update crate')
  map('v', '<space>cu', crates.update_crates, 'Update crates')
  map('n', '<space>ca', crates.update_all_crates, 'Update ALL crates')
  map('n', '<space>cU', crates.upgrade_crate, 'Upgrade crate')
  map('v', '<space>cU', crates.upgrade_crates, 'Upgrade crates')
  map('n', '<space>cA', crates.upgrade_all_crates, 'Upgrade ALL crates')

  --vim.keymap.set('n', '<space>ce', crates.expand_p desc =lain_crate_to_inline_table, {silent = true})
  --vim.keymap.set('n', '<space>cE', crates.extract_crate_into_table, {silent = true})

  map('n', '<space>cH', crates.open_homepage, 'Open homepage')
  map('n', '<space>cR', crates.open_repository, 'Open repo')
  map('n', '<space>cD', crates.open_documentation, 'Open doc')
  map('n', '<space>cC', crates.open_crates_io, 'Open crates.io')
end

return M
