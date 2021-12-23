local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap('n', '<Space>', '<NOP>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)

keymap('n', '<Esc>', ':noh<CR>', opts)

keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', opts)
keymap('n', '<Leader>o', ':e /home/cognusboi/.config/nvim/<CR>', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Stay in visual mode after indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Telescope
keymap('n', '<C-p>', ':Telescope find_files<CR>', opts)
keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)
