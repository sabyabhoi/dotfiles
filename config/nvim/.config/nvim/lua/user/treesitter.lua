require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = false,
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
