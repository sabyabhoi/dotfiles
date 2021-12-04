local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', opts)
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>o', ':e $HOME/.config/nvim/ <CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle <CR>', opts)

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)

-- vsnip
--[[if require('vsnip').jumpable(1) then
vim.api.nvim_set_keymap('i', '<Tab>', '<Cmd>vsnip-jump-next', { noremap = true, silent = true, expr = true })
end
vim.api.nvim_set_keymap('s', '<Tab>', '<Plug>(vsnip-jump-next)', { noremap = true, silent = true, expr = true })
]]

