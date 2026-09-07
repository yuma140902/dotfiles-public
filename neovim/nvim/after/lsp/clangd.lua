local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.offsetEncoding = 'utf-8'
capabilities.offset_encoding = 'utf-8'
capabilities.clang = {}
capabilities.clang.offsetEncoding = 'utf-8'
capabilities.clang.offset_encoding = 'utf-8'

local function is_linux_kernel(bufnr)
  local root = vim.fs.root(bufnr, ".git")
  if not root then
    return false
  end

  return vim.uv.fs_stat(root .. "/Kbuild") ~= nil
      and vim.uv.fs_stat(root .. "/Kconfig") ~= nil
      and vim.uv.fs_stat(root .. "/MAINTAINERS") ~= nil
end

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    if is_linux_kernel(bufnr) then
      return
    end

    on_dir(vim.fs.root(bufnr, {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git",
    }) or vim.fn.getcwd())
  end,
  capabilities = capabilities,
}
