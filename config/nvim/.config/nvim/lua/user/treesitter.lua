require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	autopairs = {
		enable = true
	},
	ensure_installed = {
		'lua',
		'vim',
		'c',
		'cpp',
		'html',
		'r',
		'rust'
	}
}
