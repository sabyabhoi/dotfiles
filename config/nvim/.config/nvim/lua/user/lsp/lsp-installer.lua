local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
	return
end

local config_status_ok, nvim_lsp = pcall(require, 'lspconfig')
if not config_status_ok then
	return
end

lsp_installer.on_server_ready(function(server) 
	local opts = {
		on_attach = require('user.lsp.handlers').on_attach,
		capabilities = require('user.lsp.handlers').capabilities
	}

	if server.name == 'astro' then
		opts.init_options = {
			configuration = {},
			typescript = {
				serverPath = ""
			}
}
	end
	--[[ if server.name == 'clangd' then
		local clangd_opts = require('user.lsp.settings.clangd')
		opts = vim.tbl_deep_extend('force', clangd_opts, opts)
	end ]]

	if server.name == 'sumneko_lua' then
		local sumneko_opts = require('user.lsp.settings.sumneko_lua')
		opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
	end

	if server.name == 'denols' then
		opts.root_dir = nvim_lsp.util.root_pattern('deno.json')
	end

	if server.name == 'tsserver' then
		opts.root_dir = nvim_lsp.util.root_pattern('package.json')
	end

	server:setup(opts)
end)
