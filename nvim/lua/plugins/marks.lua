local status_ok, marks = pcall(require, "marks")
if not status_ok then
    return
end

marks.setup {
  default_mappings = false,
  cyclic = true,
  force_write_shada = true,
  refresh_interval = 250,
  bookmark_0 = {
    sign = "⚑",
    virt_text = "",
    annotate = false,
  },
  mappings = {
    toggle_bookmark0 = "b",
    toggle = "m"
  }
}
