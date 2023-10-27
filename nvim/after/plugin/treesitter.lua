-- Help: https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },

	sync_install = false,

	-- Install new parsers with :TSInstall
	auto_install = false,

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
}
