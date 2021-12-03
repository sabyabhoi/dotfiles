local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end
	},
	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	}),
	formatting = {
		format = require('lspkind').cmp_format({ with_text = true, maxwidth = 50 })
	}
})
