-- LSP server manager
require('mason').setup {}
require('mason-lspconfig').setup {}

-- LSP completion
-- Help: https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')

cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = cmp.config.sources {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'buffer' }
	},
}


-- LSP servers
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities {}

lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.bashls.setup { capabilities = capabilities }
lspconfig.clangd.setup { capabilities = capabilities }
