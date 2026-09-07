return {
  cmd = { "cscope_lsp" },
  filetypes = { "c", "h", "cpp", "hpp" },
  workspace_required = true,
  root_markers = {
    "cscope.out",
    "cscope.files",
    "cscope.in.out",
    "cscope.out.in",
    "cscope.out.po",
    "cscope.po.out",
  },
}
