set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

Plug 'rust-lang/rust.vim'
Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'

Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  } }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()
filetype plugin indent on

set background=dark
set termguicolors
colorscheme gruvbox
syntax enable 

set nu rnu

set timeoutlen=1000 ttimeoutlen=0

set shiftwidth=4
set tabstop=4
set mouse=a
set clipboard=unnamed
set scrolloff=0

set noundofile
set nobackup

set smartindent
set autoindent
set cindent

" Add --hidden flag to the command given below to search the hidden directories as well
let $FZF_DEFAULT_COMMAND = 'rg --files '
let $FZF_DEFAULT_OPTS = '--reverse'
" Install bat to change the colorscheme for the preview window
let $BAT_THEME = 'gruvbox-dark'

nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :noh<CR>
nnoremap <Leader>n :NERDTree<CR>

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape %'
let g:Tex_ViewRule_pdf = 'zathura'
set conceallevel=1
let g:tex_conceal='abdmg'

inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-tab', ''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:python3_host_prog  = '/usr/bin/python'

nnoremap <Leader>g :Git<CR>
nnoremap <Leader>gc :Git commit<CR>

autocmd FileType markdown nnoremap <Leader>r :w \|!pandoc % -s -V geometry:a4paper -o %:r.pdf<cr><cr>
autocmd FileType markdown nnoremap <Leader>lv :!zathura %:r.pdf &<cr><cr>
autocmd FileType python nnoremap <Leader>r :w \| !python3 %<CR>
autocmd FileType cpp nnoremap <Leader>c :w \| !make FILE=%<CR>
autocmd FileType cpp set listchars=tab:\|\ 
autocmd FileType cpp set list
autocmd FileType c nnoremap <Leader>r :w \| !gcc %<CR>:!./a.out<CR>
autocmd FileType c nnoremap <Leader>c :w \| !gcc %<CR>
autocmd BufRead,BufNewFile *.conf setf dosini

autocmd FileType tex call Tex_MakeMap('<leader>ll', ':update!<CR>:call Tex_RunLaTeX()<CR>', 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap('<leader>ll', '<ESC>:update!<CR>:call Tex_RunLaTeX()<CR>', 'v', '<buffer>')

let g:Tex_Leader = ";"

function! ScrollOffToggle()
	if(&scrolloff == 999)
		set scrolloff=0
	else
		set scrolloff=999
	endif
endfunc

nnoremap <leader>st :call ScrollOffToggle()<CR>

"let g:goyo_width= 100
function! s:goyo_enter()
	set noshowmode
	set noshowcmd
	set scrolloff=999
	Limelight
endfunction

function! s:goyo_leave()
	set showmode
	set showcmd
	set scrolloff=0
	Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:notes_directories = ['/home/cognusboi/workspace/Notes']

let g:lightline = {
			\ 'colorscheme': 'gruvbox',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'FugitiveHead'
			\ },
			\ }

