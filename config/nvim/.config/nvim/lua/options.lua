local options = {
	clipboard = 'unnamedplus',
	conceallevel = 0,
	completeopt = { 'menuone', 'noselect' },
	backup = false,
	undofile = false,
	backup = false,
	hlsearch = true,
	ignorecase = false,
	mouse = 'a',
	shiftwidth = 4,
	tabstop = 4,
	nu = true,
	rnu = true,
	updatetime = 300,
	timeoutlen = 300,
	termguicolors = true,
	background = 'dark',
	cindent = true,
	smartindent = true,
	autoindent = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd 'colorscheme gruvbox'

