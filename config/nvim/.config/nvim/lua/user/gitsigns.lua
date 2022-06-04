local gitsigns_status_ok, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_status_ok then
	return
end

gitsigns.setup {
	on_attach = function(bufnr)
		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap('n', '<leader>gp', '<Cmd>Gitsigns preview_hunk<CR>', opts)
		keymap('v', '<leader>gp', ':Cmd>Gitsigns preview_hunk<CR>', opts)
		keymap('n', '<leader>gr', '<Cmd>Gitsigns reset_hunk<CR>', opts)
		keymap('v', '<leader>gr', ':Cmd>Gitsigns reset_hunk<CR>', opts)
	end
}
