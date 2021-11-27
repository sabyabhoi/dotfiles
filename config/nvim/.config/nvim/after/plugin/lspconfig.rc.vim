if !exists('g:lspconfig') | finish | endif

lua << EOF
local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local lsp_installer = require("nvim-lsp-installer")
local saga = require("lspsaga")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Mappings
	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

lsp_installer.on_server_ready(function(server)
	local opts = {}
	server:setup(opts)
end)
EOF
