local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.mdformat,
    -- python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length=100" }
    }),
    null_ls.builtins.formatting.isort,
  },
}
