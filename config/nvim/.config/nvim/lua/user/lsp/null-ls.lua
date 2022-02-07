local null_status_ok, null_ls = pcall(require, 'null-ls')
if not null_status_ok then
	return
end

null_ls.setup {
	sources = {
		null_ls.builtins.formatting.prettier.with { extra_args = {'--single-quote','--jsx-single-quote'} },
		null_ls.builtins.formatting.stylua,
	},
}
