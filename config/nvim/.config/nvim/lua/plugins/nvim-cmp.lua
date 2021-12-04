local cmp = require('cmp')
local luasnip = require('luasnip')

--vim.g.vsnip_snippet_dir = '/home/cognusboi/.config/nvim/plugin/'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" } })
cmp.setup({
	snippet = {
		expand = function(args)
			--vim.fn['vsnip#anonymous'](args.body)
			require('luasnip').lsp_expand(args.body)
		end
	},
	mapping = {
		-- ... Your other mappings ...

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'luasnip' },
		--		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	}),
	formatting = {
		format = require('lspkind').cmp_format({ with_text = true, maxwidth = 50 })
	}
})
