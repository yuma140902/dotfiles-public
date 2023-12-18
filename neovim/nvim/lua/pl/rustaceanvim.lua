local M = {}

function M.init()
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
      on_attach = require 'rc.lib'.on_attach,
      settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
        },
      },
    },
    -- DAP configuration
    dap = {
    },
  }
end

return M
