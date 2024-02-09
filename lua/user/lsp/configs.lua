--[[ local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer") ]]
--[[ if not status_ok then ]]
--[[   return ]]
--[[ end ]]

--[[ local lspconfig = require("lspconfig") ]]

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	return
end

--[[ local servers = { "jsonls", "lua_ls", "tsserver", "rust_analyzer", "pyright", "terraformls", "gopls" } ]]
--[[ local servers = { "jsonls", "tsserver", "rust_analyzer", "pyright", "terraformls", "gopls" } ]]
local servers = { "lua_ls", "jsonls", "tsserver", "rust_analyzer", "terraformls", "gopls", "pyright" }
--[[ local servers = { "jsonls", "tsserver", "rust_analyzer", "terraformls", "gopls" } ]]

--[[ lsp_installer.setup({ ]]
--[[   ensure_installed = servers, ]]
--[[ }) ]]

local on_attach = function(client, bufnr)
	--[[ vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, {}) ]]
	--[[ vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, {}) ]]
	--[[]]
	--[[ vim.keymap.set('n', '<Leader>d', vim.lsp.buf.definition, {}) ]]
	--[[ vim.keymap.set('n', '<Leader>i', vim.lsp.buf.implementation, {}) ]]
	--[[ vim.keymap.set('n', '<Leader>z', require('telescope.builtin').lsp_references, {}) ]]
	--[[ vim.keymap.set('n', 'K', vim.lsp.buf.hover, {}) ]]
	print("attaching client:", client)
	print("       to buffer:", bufnr)
	print("      PYTHONHOME=", os.getenv("PYTHONHOME"))
	print("      PYTHONPATH=", os.getenv("PYTHONPATH"))
end

mason.setup({})
mason_lspconfig.setup({ on_attach = on_attach })
--[[ require("venom").setup() ]]
mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {
			on_attach = on_attach,
			--[[ capabilities = require("user.lsp.handlers").capabilities, ]]
		}
		require("lspconfig")[server_name].setup(opts)
	end,
})

for _, server in pairs(servers) do
	local opts = {
		--[[ on_attach = require("user.lsp.handlers").on_attach, ]]
		--[[ capabilities = require("user.lsp.handlers").capabilities, ]]
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end

	lspconfig[server].setup(opts)
end

-- PyRight
local python_root_files = {
	"pyproject.toml",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
}
lspconfig["pyright"].setup({
	--[[ on_attach = on_attach, ]]
	--[[ root_dir = lspconfig.util.root_pattern(unpack(python_root_files)), ]]

	on_attach = on_attach,
	settings = {
		pyright = { autoImportCompletion = true },
		python = {
			analysis = {
				autoSearchPaths = true,
				extraPaths = { "/Users/thiagooliveira/Work/FleetOps/fleetops-core/focore" },
				--[[ diagnosticMode = "openFilesOnly", ]]
				--[[ useLibraryCodeForTypes = true, ]]
				--[[ typeCheckingMode = "off", ]]
			},
		},
	},
})

--[[ require 'lspconfig'.lua_ls.setup { ]]
--[[   settings = { ]]
--[[     Lua = { ]]
--[[       runtime = { ]]
--[[         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim) ]]
--[[         version = 'LuaJIT', ]]
--[[       }, ]]
--[[       diagnostics = { ]]
--[[         -- Get the language server to recognize the `vim` global ]]
--[[         globals = {'vim'}, ]]
--[[       }, ]]
--[[       workspace = { ]]
--[[         -- Make the server aware of Neovim runtime files ]]
--[[         library = vim.api.nvim_get_runtime_file("", true), ]]
--[[       }, ]]
--[[       -- Do not send telemetry data containing a randomized but unique identifier ]]
--[[       telemetry = { ]]
--[[         enable = false, ]]
--[[       }, ]]
--[[     }, ]]
--[[   }, ]]
--[[ } ]]
