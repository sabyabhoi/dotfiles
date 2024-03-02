local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap('n', '<Leader>f', vim.lsp.buf.format, opts)
keymap('v', '<Leader>f', vim.lsp.buf.format, opts)

keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', opts)
keymap('n', '<Leader>o', ':e /home/cognusboi/.config/nvim/<CR>', opts)

keymap('n', 'H', ':BufferLineCyclePrev<CR>', opts)
keymap('n', 'L', ':BufferLineCycleNext<CR>', opts)

keymap('n','<c-k>', ':wincmd k<CR>', opts)
keymap('n','<c-j>', ':wincmd j<CR>', opts)
keymap('n','<c-h>', ':wincmd h<CR>', opts)
keymap('n','<c-l>', ':wincmd l<CR>', opts)

keymap('n', '<Leader>gr', ':Gitsigns reset_hunk<CR>', opts)
keymap('n', '<Leader>cr', ':CompetiTest run<CR>', opts)
keymap('n', '<Leader>ce', ':CompetiTest edit_testcase<CR>', opts)
