# Custom Configuration (on top of stock LazyVim)

## Custom config files (`lua/config/`)

### `options.lua` — Global options
- **Soft-wrap enabled globally** — `wrap`, `linebreak` (wrap at word boundaries), `breakindent` (preserve indentation)
- Persistent undo history, smart-case search, and substitution previews in a split
- Snacks scrolling animations disabled

### `keymaps.lua` — Custom keybindings
| Key | Action |
|-----|--------|
| `<leader>rc` | Run current Quarto cell |
| `<leader>ra` | Run all Quarto cells above |
| `<leader>rA` | Run all Quarto cells |
| `<Esc>` (terminal) | Exit terminal mode (replaces `<C-\><C-n>`) |
| `<leader>uw` | Toggle soft-wrap on/off with notification |
| `<C-z>` / `<C-S-z>` | Undo / redo in Normal and Insert modes (Shift requires terminal support) |
| `<C-f>` | Search lines in the current buffer |

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
  - `<leader>rl` send line (normal) or selection (visual)
  - `<leader>rp` send paragraph
  - `<leader>rb` send entire buffer
  - Loads on a send shortcut, command, or as a Quarto dependency
  - Tracks the most recently entered terminal

### `editing.lua` — Search, replacement, and multiple cursors
- `<leader>sr` replaces in the current saved file; `<leader>sR` replaces in the project
- `<leader>s.` resumes the last Snacks picker
- **multicursor.nvim**, branch `1.0`, loads on Ctrl-n or a `<leader>m` shortcut
- `<leader>mn/ms/ma` add the next match, skip a match, or select all matches
- `<leader>mj/mk/mc` add a cursor below, add one above, or clear extra cursors
- which-key groups: `<leader>m` for cursors and `<leader>r` for code execution

### `startup.lua` — Deferred completion dependencies
- Tabnine and blink.compat load when completion needs them
- Automatic plugin update checks are disabled in `lua/config/lazy.lua`; use `:Lazy check`

### `quarto.lua` — Quarto documents
- **quarto-nvim** + **otter.nvim** — Quarto editing with multi-language LSP (Python, Julia, Bash, R)
- Code runner via slime
- `<leader>Qp` start preview, `<leader>Qc` close preview
- `<leader>Qf` format R code block under cursor using **air**

### `julia.lua` — Julia support
- **Julia treesitter** parser (auto-installed)
- **Julia LSP** (`julials`) via nvim-lspconfig with LanguageServer.jl + SymbolServer.jl, linting enabled
- Uses `@nvim-lsp` and excludes Julia from Mason's automatic setup, avoiding synchronous environment discovery
- Project discovery runs in the server process; the project's path is passed to LanguageServerInstance
- `queries/julia/textobjects.scm` splits expensive conditional patterns to reduce query compilation time

### `typst.lua` — Typst support
- `<leader>tp` / `<leader>ts` start / stop preview only in Typst buffers
- The Python REPL mapping remains available in other buffers

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
