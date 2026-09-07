return {
  cmd = { "zshcs" },
  filetypes = { "zsh" },
  root_markers = { ".git" },
  -- Optional: Enable experimental features (definition, diagnostics, hover, symbols)
  settings = {
    zshcs = {
      experimental = {
        definition = true,
        diagnostics = true,
        hover = true,
        symbols = true,
      },
    },
  },
}
