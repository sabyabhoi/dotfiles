let mapleader = " "

nnoremap <Leader>n :NERDTreeToggle <CR>
nnoremap <Leader>o :e ~/.config/nvim <CR>
nnoremap <silent><Esc> :noh <CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>

autocmd FileType c nnoremap <Leader>r :w \| !make FILE=% && ./a.out<CR>
autocmd FileType cpp nnoremap <Leader>r :w \| !make FILE=%<CR>
autocmd FileType nroff nnoremap <Leader>r :w \| !groff -ms % -T pdf > %:r.pdf<CR>
autocmd FileType nroff nnoremap <Leader>lv :!zathura %:r.pdf & disown<CR>
nmap <leader>p <Plug>(coc-rename)

