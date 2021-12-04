local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'

	-- Completion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'
	--	use 'hrsh7th/cmp-vsnip'
	--	use 'hrsh7th/vim-vsnip'
	use {
		'L3MON4D3/LuaSnip',
		requires = {{'saadparwaiz1/cmp_luasnip'}}

	}
	use 'onsails/lspkind-nvim'
	use "rafamadriz/friendly-snippets"

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- Misc
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {} end
	}
	use 'jiangmiao/auto-pairs'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{ 'nvim-lua/plenary.nvim' }}
	}

	-- LaTeX
	use 'lervag/vimtex'
	use 'vim-latex/vim-latex'

	-- Colorschemes
	use 'morhetz/gruvbox'
end)

