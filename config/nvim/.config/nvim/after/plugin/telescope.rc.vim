if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <Leader>lg <cmd>Telescope live_grep<cr>
nnoremap <silent> <Leader>b <cmd>Telescope buffers<cr>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF
