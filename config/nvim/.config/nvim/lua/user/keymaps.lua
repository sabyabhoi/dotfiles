local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap('n', '<Space>', '<NOP>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.BASH_Ctrl_j = 'off'

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

keymap('n', '<Leader>f', vim.lsp.buf.formatting_sync, opts)

-- Telescope
keymap('n', '<C-p>', ':Telescope find_files<CR>', opts)
keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)
keymap('n', '<Leader>lg', ':Telescope live_grep<CR>', opts)

-- Bufferline
keymap('n', 'H', ':BufferLineCyclePrev<CR>', opts)
keymap('n', 'L', ':BufferLineCycleNext<CR>', opts)

-- Plenary
vim.cmd [[nmap <leader>t <Plug>PlenaryTestFile]]
