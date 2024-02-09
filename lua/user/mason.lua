require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	--[[ ensure_installed = vim.tbl_keys(servers), ]]
})

require("mason-null-ls").setup({})

--[[ mason_lspconfig.setup_handlers({ ]]
--[[ 	function(server_name) ]]
--[[ 		require("lspconfig")[server_name].setup({ ]]
--[[ 			capabilities = capabilities, ]]
--[[ 			on_attach = on_attach, ]]
--[[ 			settings = servers[server_name], ]]
--[[ 		}) ]]
--[[ 	end, ]]
--[[ }) ]]
