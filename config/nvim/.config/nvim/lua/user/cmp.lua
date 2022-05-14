local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
	return
end

luasnip.config.set_config {
	history = false,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true
}

require('luasnip.loaders.from_snipmate').lazy_load()

-- local check_backspace = function()
-- 	local col = vim.fn.col '.' - 1
-- 	return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
-- end

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = {
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<Tab>'] = cmp.mapping.confirm { select = true },
		['<C-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else 
				fallback()
			end
		end, {'i', 's'}),
		['<C-k>'] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' })
	},
	sources = cmp.config.sources({
		{ name = 'buffer' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
	}),
	formatting = {
		format = require('lspkind').cmp_format({
			with_text = true,
			maxwidth = 50,
		})
	}
}
