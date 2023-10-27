local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('github/copilot.vim')
Plug('preservim/nerdtree')

-- Theme
Plug('dracula/vim')

-- Git diff
Plug('airblade/vim-gitgutter')

-- Language parser; Syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- LSP server manager
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

-- LSP completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

-- LSP snippets
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')

-- LSP support
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

-- Keymaps
require('keymaps')

-- Vim settings
vim.cmd('set nu')

vim.cmd('color dracula')
vim.cmd('set termguicolors')

vim.cmd('set tabstop=2')
