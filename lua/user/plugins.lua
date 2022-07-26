local function setup(use)
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })

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

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "saadparwaiz1/cmp_luasnip" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/nvim-lsp-installer" })
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "p00f/nvim-ts-rainbow" })

	-- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- Nvim tree
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

	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
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
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(setup)
