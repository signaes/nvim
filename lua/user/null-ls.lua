local status_ok, nullls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = nullls.builtins.formatting
local diagnostics = nullls.builtins.diagnostics
local completion = nullls.builtins.completion
--[[ local augroup = vim.api.nvim_create_augroup("LspFormatting", {}) ]]
--[[ local lsp_format = function(bufnr) ]]
--[[   -- 	-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead ]]
--[[   vim.lsp.buf.format({ ]]
--[[     -- on 0.8 ]]
--[[     filter = function(client) ]]
--[[       -- apply whatever logic you want (in this example, we'll only use null-ls) ]]
--[[       return client.name == "null-ls" ]]
--[[     end, ]]
--[[     bufnr = bufnr, ]]
--[[   }) ]]
--[[ end ]]

nullls.setup({
	sources = {
    -- code_actions
    nullls.builtins.code_actions.refactoring,
		-- formatting
		formatting.stylua,
		formatting.prettier,
		formatting.black,
    formatting.isort,
		formatting.rustfmt,
		formatting.gofmt,
		formatting.goimports,
		-- diagnostics
		diagnostics.flake8,
		diagnostics.pylint,
		diagnostics.eslint,
		-- diagnostics.eslint.with({
		-- 	prefer_local = "node_modules/.bin",
		-- }),
		--[[ completion, ]]
		--[[ completion.spell, ]]
    --[[ nullls.builtins.completion.luasnip, ]]
	},

	--[[ on_attach = function(client, bufnr) ]]
	--[[ 	if client.supports_method("textDocument/formatting") then ]]
	--[[ 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr }) ]]
	--[[]]
	--[[ 		vim.api.nvim_create_autocmd("BufWritePre", { ]]
	--[[ 			group = augroup, ]]
	--[[ 			buffer = bufnr, ]]
	--[[ 			callback = function() ]]
	--[[ 				lsp_format(bufnr) ]]
	--[[ 			end, ]]
	--[[ 		}) ]]
	--[[ 	end ]]
	--[[ end, ]]
})
