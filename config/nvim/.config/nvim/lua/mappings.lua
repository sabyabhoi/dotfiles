local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', opts)
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>o', ':e $HOME/.config/nvim/ <CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle <CR>', opts)

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)
