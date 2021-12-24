vim.cmd [[packadd packer.nvim]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

packer.init {
	display = {
		open_fn = function()
			return require('packer.util').float { border = 'rounded' }
		end
	}
}

return packer.startup(function()
	use 'wbthomason/packer.nvim'
	use 'gruvbox-community/gruvbox'
	use 'folke/tokyonight.nvim'

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		'williamboman/nvim-lsp-installer',
	}
	use 'simrat39/rust-tools.nvim'

	-- Completion
	use {
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-nvim-lsp',
		'jiangmiao/auto-pairs',
	}

	-- Snippets
	use {
		'saadparwaiz1/cmp_luasnip',
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets',
		'onsails/lspkind-nvim',
	}

	use 'kyazdani42/nvim-web-devicons'
	use {
		'nvim-lualine/lualine.nvim',
		config = function() require('lualine').setup() end
	}

	use {
		'kyazdani42/nvim-tree.lua',
		config = function() require'nvim-tree'.setup {} end
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {{ 'nvim-lua/plenary.nvim' }}
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
end)
