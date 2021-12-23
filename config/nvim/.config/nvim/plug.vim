call plug#begin('/home/cognusboi/.local/share/nvim/plugged')

" --- LSP STUFF ---
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'

" --- AUTO-COMPLETE STUFF ---
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'

Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdtree' 
Plug 'preservim/nerdcommenter'

" --- FILE SPECIFIC ---
Plug 'rust-lang/rust.vim'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'mattn/emmet-vim'
Plug 'tikhomirov/vim-glsl'
Plug 'chrisbra/csv.vim'

" flutter
Plug 'natebosch/dartlang-snippets'
Plug 'dart-lang/dart-vim-plugin'

" latex
Plug 'lervag/vimtex'
Plug 'vim-latex/vim-latex'

" --- GIT(HUB) ---
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" --- THEMES & AESTHETICS ---
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'dylanaraps/wal.vim'

" --- MISC ---
Plug 'hoob3rt/lualine.nvim'

call plug#end()
let g:lsc_auto_map = v:true
