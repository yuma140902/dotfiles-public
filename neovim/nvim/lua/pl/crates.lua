local M = {}

function M.config()
  require 'crates'.setup()

  -- nvim-cmpソースの追加
  -- TODO: 機能していない気がする
  vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
      require 'cmp'.setup.buffer({ sources = { { name = "crates" } } })
    end,
  })

  -- キーマップの追加
  -- TODO: 'rc/lib'.mapを使う
  local crates = require('crates')

  vim.keymap.set('n', '<space>ct', crates.toggle, { silent = true, desc = 'Toggle' })
  vim.keymap.set('n', '<space>cr', crates.reload, { silent = true, desc = 'Reload' })

  vim.keymap.set('n', '<space>cv', crates.show_versions_popup, { silent = true, desc = 'Show versions popup' })
  vim.keymap.set('n', '<space>cf', crates.show_features_popup, { silent = true, desc = 'Show features popup' })
  vim.keymap.set('n', '<space>cd', crates.show_dependencies_popup,
    { silent = true, desc = 'Show dependencies popup' })

  vim.keymap.set('n', '<space>cu', crates.update_crate, { silent = true, desc = 'Update crate' })
  vim.keymap.set('v', '<space>cu', crates.update_crates, { silent = true, desc = 'Update crates' })
  vim.keymap.set('n', '<space>ca', crates.update_all_crates, { silent = true, desc = 'Update ALL crates' })
  vim.keymap.set('n', '<space>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade crate' })
  vim.keymap.set('v', '<space>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade crates' })
  vim.keymap.set('n', '<space>cA', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade ALL crates' })

  --vim.keymap.set('n', '<space>ce', crates.expand_plain_crate_to_inline_table, {silent = true})
  --vim.keymap.set('n', '<space>cE', crates.extract_crate_into_table, {silent = true})

  vim.keymap.set('n', '<space>cH', crates.open_homepage, { silent = true, desc = 'Open homepage' })
  vim.keymap.set('n', '<space>cR', crates.open_repository, { silent = true, desc = 'Open repo' })
  vim.keymap.set('n', '<space>cD', crates.open_documentation, { silent = true, desc = 'Open doc' })
  vim.keymap.set('n', '<space>cC', crates.open_crates_io, { silent = true, desc = 'Open crates.io' })
end

return M
