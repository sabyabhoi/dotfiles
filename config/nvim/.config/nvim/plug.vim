call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'scrooloose/nerdtree' 
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
"Plug 'plasticboy/vim-markdown'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'
Plug 'vim-latex/vim-latex'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'

Plug 'rust-lang/rust.vim'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'

" flutter
Plug 'natebosch/dartlang-snippets'
Plug 'dart-lang/dart-vim-plugin'

Plug 'morhetz/gruvbox'

Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " lua
Plug 'ryanoasis/vim-devicons' " vimscript
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()
let g:lsc_auto_map = v:true
