let mapleader = " "

nnoremap <Leader>n :NERDTreeToggle <CR>
nnoremap <Leader>o :e ~/.config/nvim <CR>
nnoremap <silent><Esc> :noh <CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>

autocmd FileType c nnoremap <Leader>r :w \| !gcc -Wall % && ./a.out<CR>
autocmd FileType cpp nnoremap <Leader>r :w \| !make FILE=%<CR>
nmap <leader>cn <Plug>(coc-rename)
