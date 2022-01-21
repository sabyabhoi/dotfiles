local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server) 
	local opts = {
		on_attach = require('user.lsp.handlers').on_attach,
		capabilities = require('user.lsp.handlers').capabilities
	}

--	if server.name == 'clangd' then
--		local clangd_opts = require('user.lsp.settings.clangd')
--		opts = vim.tbl_deep_extend('force', clangd_opts, opts)
--	end
	server:setup(opts)
end)
