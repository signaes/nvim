local function setup(use)
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/popup.nvim" })

	-- Colors
	use({ "folke/tokyonight.nvim" })

	-- Text editing
	use({ "tpope/vim-surround" })
	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "terryma/vim-multiple-cursors" })
	use({ "RRethy/vim-illuminate" })

	-- Comments
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })

	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })

	use({
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	})

	-- LSP
	use({ "williamboman/mason-lspconfig.nvim" })
	use({
		"williamboman/mason.nvim",
		config = true,
		run = ":MasonUpdate",
	})

	-- DAP (Debug Adapter Protocol)
	use({ "mfussenegger/nvim-dap" })
	use({ "mfussenegger/nvim-dap-python" })

	use({ "j-hui/fidget.nvim", opts = {} })
	use({ "folke/neodev.nvim" })
	use({
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			"j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	})

	--[[ use({ ]]
	--[[ 	"HallerPatrick/py_lsp.nvim", ]]
	--[[ 	-- Support for versioning ]]
	--[[ 	-- tag = "v0.0.1" ]]
	--[[ }) ]]
	--
	use({ "folke/neoconf.nvim" })
	--[[ use({ ]]
	--[[ 	"rafi/neoconf-venom.nvim", ]]
	--[[ 	dependencies = { "nvim-lua/plenary.nvim", "folke/neoconf.nvim" }, ]]
	--[[ }) ]]

	--
	--[[ use({ "williamboman/nvim-lsp-installer" }) ]]
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "MunifTanjim/prettier.nvim" })
	use({ "jay-babu/mason-null-ls.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.5" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "p00f/nvim-ts-rainbow" })

	-- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- Nvim tree
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
	})

	-- UI
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

	-- Toggleterm
	use({ "akinsho/toggleterm.nvim", tag = "v2.*" })

	-- Rust
	use({ "simrat39/rust-tools.nvim" })

	-- Terraform
	use({ "hashivim/vim-terraform" })

	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		local ok, packer = pcall(require, "packer")

		if not ok then
			return
		end

		packer.sync()
	end
end

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})

	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			local ok, packer_util = pcall(require, "packer.util")

			if not ok then
				return
			end

			return packer_util.float({ border = "rounded" })
		end,
	},
})

return packer.startup(setup)
