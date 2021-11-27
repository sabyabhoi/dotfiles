if !exists('g:loaded_cmp') | finish | endif

set completeopt=menuone,noinsert,noselect

" Tab complete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

lua << EOF
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args) 
			vim.fn["vsnip#anonymous"](args.body)
		end
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 3 },
	},
	snippet = {
		expand = function(args) 
			require("luasnip").lsp_expand(args.body)
		end
	}
})
EOF
