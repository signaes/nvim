local status_ok, nullls = pcall(require, "null-ls")
if not status_ok then
	return
end

local group = vim.api.nvim_create_augroup("lsp_format", { clear = false })
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

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>l", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>l", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format range" })
		end
	end,
})
