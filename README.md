```shell
███╗   ██╗██╗   ██╗██╗███╗   ███╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
████╗  ██║██║   ██║██║████╗ ████║    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
██╔██╗ ██║██║   ██║██║██╔████╔██║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
```

## Requirements

- [curl](https://github.com/curl/curl)
- [neovim](https://github.com/neovim/neovim) (>= 0.10)
- [npm](https://github.com/npm/cli)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

---

#### Nvim configuration layout

```shell
nvim
├── lua
│   └── rwxmad
│       ├── plugins ===============> Plugins configs
│       │   ├── coding.lua
│       │   ├── completion.lua
│       │   ├── editor.lua
│       │   ├── lsp.lua
│       │   ├── telescope.lua
│       │   ├── treesitter.lua
│       │   ├── ui.lua
│       │   └── util.lua
│       ├── snippets ==============> Snippets
│       │   └── frontend.lua
│       ├── util ==================> Utils
│       │   ├── common.lua
│       │   ├── completion.lua
│       │   ├── lsp.lua
│       │   └── snippets.lua
│       ├── colors.lua ============> Colorscheme
│       ├── defaults.lua ==========> Variables
│       ├── keymaps.lua ===========> Keymaps
│       └── options.lua ===========> General settings
├── init.lua ======================> Root config file
├── lazy-lock.json
├── README.md
└── stylua.toml
```

---

## Main mappings

- `<Leader>` key set as `,`
- `<Escape>` from insert mode can be applied by `jj`
- `<leader>` `w` - Write file
- `<leader>` `q` - Quit

---

### Some basic mappings

| Keymap            | Description                                                                                                    |
| ----------------- | -------------------------------------------------------------------------------------------------------------- |
| `<leader><space>` | Turn off search highlight                                                                                      |
| `<leader>` `ff`   | Lists files in your current working directory                                                                  |
| `<leader>` `fb`   | Telescope file browser                                                                                         |
| `<leader>` `fg`   | Search for a string in your current working directory and get results live as you type (respecting .gitignore) |
| `<leader>` `bg`   | Search for a string in your current buffer                                                                     |
| `<leader>` `gg`   | Open lazygit                                                                                                   |

---

## Plugins

| Plugin                                          | Description                           |
| ----------------------------------------------- | ------------------------------------- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 💤 A modern plugin manager for Neovim |

---

## Language servers

- [html](https://github.com/hrsh7th/vscode-langservers-extracted)
- [cssls](https://github.com/hrsh7th/vscode-langservers-extracted)
- [ts_ls](https://github.com/typescript-language-server/typescript-language-server)
- [eslint](https://github.com/hrsh7th/vscode-langservers-extracted)
- [volar](https://github.com/vuejs/language-tools/tree/master/packages/language-server)
- [emmet_ls](https://github.com/aca/emmet-ls)
- [tailwindcss](https://github.com/tailwindlabs/tailwindcss-intellisense)
- [rust_analyzer](https://github.com/rust-lang/rust-analyzer)
- [jsonls](https://github.com/hrsh7th/vscode-langservers-extracted)
- [lua_ls](https://github.com/luals/lua-language-server)
- [pyright](https://github.com/microsoft/pyright)
- [bashls](https://github.com/bash-lsp/bash-language-server)
- [marksman](https://github.com/artempyanykh/marksman)

---

## [Full LSP servers list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)
