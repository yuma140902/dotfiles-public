--@type LazySpec
return {
  -- フォーマット
  'https://github.com/stevearc/conform.nvim',
  cond = not vim.g.vscode,
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',

  init = function()
    vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,

  config = function()
    require 'conform'.setup {
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        css = { "biome" },
        graphql = { "biome" },
        html = { "biome" },
      },
      default_format_opts = {
        lsp_format = 'fallback'
      },
      format_after_save = function(bufnr)
        if vim.b[bufnr].no_format == 1 then
          return
        end
        return {
          lsp_format = 'fallback',
          async = true,
        }
      end,
      notify_no_formatters = true,
    }
  end,
}
