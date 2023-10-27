# My Config

## Neovim

 - [neovim](https://github.com/neovim/neovim): hyperextensible vim-based text editor
 - [vim-plug](https://github.com/junegunn/vim-plug): minimalist vim plugin manager

### Plugins:
 - copilot
 - nerdtree
 - dracula (theme)
 - treesitter
 - mason and mason-lspconfig
 - cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline and nvim-cmp
 - cmp-vsnip and vim-vsnip
 - nvim-lspconfig

## Script installation

Clone repository:
```bash
git clone https://github.com/gsistelos/my-config.git
```

Run script:
```bash
cd my-config && ./script.sh
```

Move nvim directory to ~/.config
```bash
mv nvim ~/.config
```

Inside nvim, run `:PlugInstall`
