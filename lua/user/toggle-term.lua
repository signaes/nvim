local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
  size = 20,
	open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shell = vim.o.shell,
	direction = "float",
	close_on_exit = true,
	float_opts = {
		border = "curved",
	},
})
