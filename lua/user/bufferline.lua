local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup {
  options = {
    mode = "tabs",
    modified_icon = '●',
    diagnostics = "nvim_lsp",
    persist_buffer_sort = false,
  }
}
