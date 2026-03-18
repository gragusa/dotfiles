# Custom Configuration (on top of stock LazyVim)

## Custom config files (`lua/config/`)

### `options.lua` — Global options
- **Soft-wrap enabled globally** — `wrap`, `linebreak` (wrap at word boundaries), `breakindent` (preserve indentation)

### `keymaps.lua` — Custom keybindings
| Key | Action |
|-----|--------|
| `<leader>rc` | Run current Quarto cell |
| `<leader>ra` | Run all Quarto cells above |
| `<leader>rA` | Run all Quarto cells |
| `<Esc>` (terminal) | Exit terminal mode (replaces `<C-\><C-n>`) |
| `<leader>uw` | Toggle soft-wrap on/off with notification |

### `autocmds.lua` — Autocommands
- For **quarto/markdown** files: `conceallevel=0` (shows ` ``` ` fences instead of hiding them) and disables backtick auto-pairing

---

## Custom plugins (`lua/plugins/`)

### `repl.lua` — Terminal & REPL
- **toggleterm.nvim** — persistent terminal panes, vertical split at 40% width
  - `<C-\>` toggle terminal
  - `<leader>tj` dedicated Julia REPL
  - `<leader>tp` dedicated Python REPL
- **vim-slime** — send code from editor to terminal
  - `<leader>ss` send line (normal) or selection (visual)
  - `<leader>sp` send paragraph
  - `<leader>sb` send entire buffer
  - Auto-detects the last opened terminal

### `quarto.lua` — Quarto documents
- **quarto-nvim** + **otter.nvim** — Quarto editing with multi-language LSP (Python, Julia, Bash, R)
- Code runner via slime
- `<leader>Qp` start preview, `<leader>Qc` close preview
- `<leader>Qf` format R code block under cursor using **air**

### `julia.lua` — Julia support
- **Julia treesitter** parser (auto-installed)
- **Julia LSP** (`julials`) via nvim-lspconfig with LanguageServer.jl + SymbolServer.jl, linting enabled

### `r.lua` — R support
- **R treesitter** parser (auto-installed)
- **conform.nvim** configured with **air** formatter for `.R` and `.Rmd` files

### `latex.lua` — LaTeX support
- **texlab** LSP with latexmk build-on-save and forward search via macOS `open`

---

## LazyVim extras enabled (`lazyvim.json`)
- `ai.tabnine` — AI completion
- `coding.luasnip` — snippet engine
- `lang.markdown` — markdown support
- `lang.python` — Python LSP
- `lang.tex` — LaTeX support
- `util.chezmoi` — dotfile management
