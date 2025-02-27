local M = {}

function M.config()
  require 'conform'.setup {
    formatters_by_ft = {},
    default_format_opts = {
      lsp_format = "fallback"
    },
    format_after_save = function(bufnr)
      if vim.b[bufnr].no_format == 1 then
        return
      end
      return {
        lsp_format = "fallback",
        async = true,
        filter = function(client_)
          -- bufnrとclient_をもとに、各LSPサーバでフォーマットを行うかどうか決定する
          if client_.name == 'ts_ls' or client_.name == 'null-ls' then
            -- biomeがアタッチされているとき、ts_lsやnull-lsではフォーマットしない
            local biome_attached = #(vim.lsp.get_clients({ bufnr = bufnr, name = 'biome' })) ~= 0
            if biome_attached then
              return false
            end
          end
          return true
        end,
      }
    end,
    notify_no_formatters = true,
  }
end

function M.init()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return M
