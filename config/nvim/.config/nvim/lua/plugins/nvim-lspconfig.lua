local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command [[augroup Format]]
		vim.api.nvim_command [[autocmd! * <buffer>]]
		vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
		vim.api.nvim_command [[augroup END]]
	end
end

-- Setup nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
require('nvim-lsp-installer').on_server_ready(function(server)
    local opts = {}

	if server.name == 'sumneko_lua' then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim', 'use' }
				}
			}
		}
	end

	if server.name == 'tsserver' then
		opts = {
			on_attach = on_attach,
			capabilities = capabilities
		}
	end

	if server.name == 'diagnosticls' then
		opts = {
			on_attach = on_attach,
			filetypes = { 'javascript', 'typescript', 'json', 'javascriptreact', 'typescriptreact', 'css', 'less', 'scss' },
			init_options = {
				linters = {
					eslint = {
						command = 'eslint_d',
						rootPatterns = { '.git' },
						debounce = 100,
						args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
						sourceName = 'eslint_d',
					},
					parseJson = {
						errorsRoot = '[0].messages',
						line = 'line',
						column = 'column',
						endLine = 'endLine',
						endColumn = 'endColumn',
						message = '[eslint] ${message} [${ruleId}]',
						security = 'severity'
					},
					securities = {
						[2] = 'error',
						[1] = 'warning'
					}
				},
			},
			formatters = {
				eslint_d = {
					command = 'eslint_d',
					rootPatterns = { '.git' },
					args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
				},
				prettier = {
					command = 'prettier_d_slim',
					rootPatterns = { '.git' },
					-- requiredFiles: { 'prettier.config.js' },
					args = { '--stdin', '--stdin-filepath', '%filename' }
				}
			},
			formatFiletypes = {
				css = 'prettier',
				javascript = 'prettier',
				javascriptreact = 'prettier',
				scss = 'prettier',
				less = 'prettier',
				typescript = 'prettier',
				typescriptreact = 'prettier',
				json = 'prettier',
				markdown = 'prettier',
			}
		}
	end

	server:setup(opts)
end)
