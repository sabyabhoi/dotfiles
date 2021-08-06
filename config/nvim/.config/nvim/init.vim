source ~/.config/nvim/plug.vim

set nu rnu
syntax on
set nobackup
set noundofile

set background=dark
set termguicolors
colorscheme gruvbox

set shiftwidth=4
set tabstop=4
set mouse=a
set clipboard+=unnamedplus

source ~/.config/nvim/maps.vim

set smartindent
set cindent
set autoindent

set timeoutlen=1000 ttimeoutlen=0

set conceallevel=2

autocmd! BufNewFile,BufRead *.shader set ft=glsl
