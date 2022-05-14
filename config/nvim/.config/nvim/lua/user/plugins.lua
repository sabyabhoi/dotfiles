--local fn = vim.fn
--local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--if fn.empty(fn.glob(install_path)) > 0 then
--  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--end

vim.cmd([[packadd packer.nvim]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Colorschemes
	use({
		"gruvbox-community/gruvbox",
		"folke/tokyonight.nvim",
		"nanotech/jellybeans.vim",
	})
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
		"jose-elias-alvarez/null-ls.nvim",
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"windwp/nvim-autopairs",
	})

	-- Snippets
	use({
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"honza/vim-snippets",
		"onsails/lspkind-nvim",
	})

	-- Comment stuff
	use("numToStr/Comment.nvim")
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})
	-- Filetype specific
	use({
		"mattn/emmet-vim",
		"vim-latex/vim-latex",
		"elkowar/yuck.vim",
		"jalvesaq/Nvim-R",
	})

	use("kyazdani42/nvim-web-devicons")
	use("lukas-reineke/indent-blankline.nvim")

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup()
		end,
	})
	use("akinsho/bufferline.nvim")

	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end,
	})

	use({ "akinsho/toggleterm.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("junegunn/goyo.vim")
	use("lewis6991/gitsigns.nvim")

	-- custom plugins
	use("/home/cognusboi/workspace/userfiles/programming/Lua/stackmap.nvim")
end)
