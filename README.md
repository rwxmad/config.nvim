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
- [fd](https://github.com/sharkdp/fd)

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

| Plugin                                                                                        | Description                                                                                                                                       |
| --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                                 | A snazzy bufferline for Neovim                                                                                                                    |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                                           | nvim-cmp source for buffer words                                                                                                                  |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                                       | nvim-cmp source for neovim builtin LSP client                                                                                                     |
| [cmp-path](https://github.com/hrsh7th/cmp-path)                                               | nvim-cmp source for path                                                                                                                          |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)                                    | luasnip completion source for nvim-cmp                                                                                                            |
| [conform.nvim](https://github.com/stevearc/conform.nvim)                                      | Lightweight yet powerful formatter plugin for Neovim                                                                                              |
| [flash.nvim](https://github.com/folke/flash.nvim)                                             | Navigate your code with search labels, enhanced character motions and Treesitter integration                                                      |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                                   | Git integration for buffers                                                                                                                       |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                                               | 💤 A modern plugin manager for Neovim                                                                                                             |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim)                                       | vscode-like pictograms for neovim lsp completion items                                                                                            |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                                  | A blazing fast and easy to configure neovim statusline plugin written in pure lua                                                                 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                                | Snippet Engine for Neovim written in Lua                                                                                                          |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)                  | Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim                                                                     |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)     | Install and upgrade third party tools automatically                                                                                               |
| [mason.nvim](https://github.com/williamboman/mason.nvim)                                      | Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters |
| [mini.animate](https://github.com/echasnovski/mini.animate)                                   | Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library                                                                   |
| [mini.bracketed](https://github.com/echasnovski/mini.bracketed)                               | Neovim Lua plugin to go forward/backward with square brackets. Part of 'mini.nvim' library                                                        |
| [mini.nvim](https://github.com/echasnovski/mini.nvim)                                         | Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort                           |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim)                                         | Faster LuaLS setup for Neovim                                                                                                                     |
| [noice.nvim](https://github.com/folke/noice.nvim)                                             | 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu                                             |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim)                                           | UI Component Library for Neovim                                                                                                                   |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                               | A completion plugin for neovim coded in Lua                                                                                                       |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                                    | Quickstart configs for Nvim LSP                                                                                                                   |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                | Clipboard manager neovim plugin with telescope integration                                                                                        |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                         | Nvim Treesitter configurations and abstraction layer                                                                                              |
| [nvim-treesitter-refactor](https://github.com/nvim-treesitter/nvim-treesitter-refactor)       | Refactor module for nvim-treesitter                                                                                                               |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Syntax aware text-objects, select, move, swap, and peek support                                                                                   |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)         | Show code context                                                                                                                                 |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                                  | Use treesitter to auto close and auto rename html tag                                                                                             |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)                           | Provides Nerd Font icons (glyphs) for use by neovim plugins                                                                                       |
| [oil.nvim](https://github.com/stevearc/oil.nvim)                                              | Neovim file explorer: edit your filesystem like a buffer                                                                                          |
| [persistence.nvim](https://github.com/folke/persistence.nvim)                                 | 💾 Simple session management for Neovim                                                                                                           |
| [playground](https://github.com/nvim-treesitter/playground)                                   | Treesitter playground integrated into Neovim                                                                                                      |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)                                      | plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice                                         |
| [presence.nvim](https://github.com/andweeb/presence.nvim)                                     | Discord Rich Presence for Neovim                                                                                                                  |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                                           | 🍿 A collection of QoL plugins for Neovim                                                                                                         |
| [solarized-osaka.nvim](https://github.com/craftzdog/solarized-osaka.nvim)                     | 🏯 A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins                                                |
| [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)  | File Browser extension for telescope.nvim                                                                                                         |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)      | FZF sorter for telescope written in c                                                                                                             |
| [telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim)    | Telescope extension to preview media files using Ueberzug                                                                                         |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                            | Find, Filter, Preview, Pick. All lua, all the time                                                                                                |
| [ts-comments.nvim](https://github.com/folke/ts-comments.nvim)                                 | Tiny plugin to enhance Neovim's native comments                                                                                                   |
| [vim-dadbod](https://github.com/tpope/vim-dadbod)                                             | Modern database interface for Vim                                                                                                                 |
| [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)              | Database autocompletion powered by https://github.com/tpope/vim-dadbod                                                                            |
| [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)                              | Simple UI for https://github.com/tpope/vim-dadbod                                                                                                 |
| [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim)                                 | Incremental LSP renaming based on Neovim's command-preview feature                                                                                |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                               | Neovim plugin to manage the file system and other tree like structures                                                                            |
| [neogen](https://github.com/danymat/neogen)                                                   | A better annotation generator. Supports multiple languages and annotation conventions                                                             |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                             | ✅ Highlight, list and search todo comments in your projects                                                                                      |
| [trouble.nvim](https://github.com/folke/trouble.nvim)                                         | 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing         |

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
