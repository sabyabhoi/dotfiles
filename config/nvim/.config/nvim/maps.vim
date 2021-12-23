let mapleader = " "

nnoremap <Leader>n :NERDTreeToggle <CR>
nnoremap <Leader>o :e ~/.config/nvim <CR>
nnoremap <silent><Esc> :noh <CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>

autocmd FileType c nnoremap <Leader>r :w \| !make FILE=% && ./a.out<CR>
autocmd FileType python nnoremap <Leader>r :w \| !python %<CR>
autocmd FileType cpp nnoremap <Leader>r :w \| !make FILE=%<CR>
autocmd FileType nroff nnoremap <silent><leader>r :w \| !groff_compile % <CR>
autocmd FileType nroff nnoremap <silent><Leader>lv :!zathura %:r.pdf & disown<CR>
autocmd FileType dot nnoremap <Leader>r :w \| !dot -Tpng % -o %:r.png<CR>
autocmd FileType rust nnoremap <silent><Leader>r :RustRun<CR>
nmap <leader>p <Plug>(coc-rename)

autocmd FileType tex call Tex_MakeMap("<Leader>ll", ":w <CR> <Plug>Tex_Compile", 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap("<Leader>ll", "<ESC> :w <CR> <Plug>Tex_Compile", 'v', '<buffer>')

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

autocmd! BufNewFile,BufRead *.shader set ft=glsl
autocmd! BufNewFile,BufRead *.ms set ft=nroff
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
