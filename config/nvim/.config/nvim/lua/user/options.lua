local options = {
	clipboard = 'unnamedplus',
	conceallevel = 0,
	completeopt = { 'menu', 'menuone', 'noselect' },
	backup = false,
	undofile = false,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,
	mouse = 'a',
	shiftwidth = 2,
	tabstop = 2,
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

vim.cmd [[colorscheme tokyonight]]
vim.cmd [[autocmd BufNewFile,BufRead *.tex :set filetype=tex]]
