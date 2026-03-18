# Neovim Cheatsheet

Leader key: `<Space>`

## Basics

| Key | Mode | Action |
|-----|------|--------|
| `i` | N | Enter insert mode (before cursor) |
| `a` | N | Enter insert mode (after cursor) |
| `o` / `O` | N | New line below / above and enter insert |
| `<Esc>` | I | Back to normal mode |
| `v` | N | Visual (character) selection |
| `V` | N | Visual line selection |
| `<C-v>` | N | Visual block selection |
| `:w` | N | Save file |
| `:q` | N | Quit (`:wq` save & quit, `:q!` force quit) |
| `ZZ` | N | Save and quit |

## Navigation

| Key | Mode | Action |
|-----|------|--------|
| `h/j/k/l` | N | Left / Down / Up / Right |
| `w` / `b` | N | Next / previous word |
| `0` / `$` | N | Start / end of line |
| `gg` / `G` | N | Top / bottom of file |
| `{` / `}` | N | Previous / next paragraph |
| `<C-d>` / `<C-u>` | N | Scroll half-page down / up |
| `<C-f>` / `<C-b>` | N | Scroll full page down / up |
| `gj` / `gk` | N | Move down/up by visual line (useful with soft-wrap) |

## Editing

| Key | Mode | Action |
|-----|------|--------|
| `dd` | N | Delete (cut) line |
| `yy` | N | Yank (copy) line |
| `p` / `P` | N | Paste after / before cursor |
| `ciw` | N | Change inner word |
| `ci"` | N | Change inside quotes |
| `diw` | N | Delete inner word |
| `>>` / `<<` | N | Indent / unindent line |
| `.` | N | Repeat last change |
| `~` | N | Toggle case of character |

## Undo / Redo

| Key | Mode | Action |
|-----|------|--------|
| `u` | N | Undo last change |
| `<C-r>` | N | Redo (undo the undo) |
| `U` | N | Undo all changes on current line |

Undo in Neovim is tree-based: if you undo and then make a new edit,
the old redo branch is preserved. Use `:earlier 5m` / `:later 5m` to
travel through time, or install a plugin like `undotree` to visualize it.

## Multi-Cursor / Bulk Editing

Neovim doesn't have built-in multi-cursor like VS Code, but achieves
the same results with these techniques:

### Visual Block Mode (the most common approach)
1. `<C-v>` to enter visual block mode
2. `j`/`k` to extend the selection across lines
3. Then:
   - `I` to insert text at the start of each line (type, then `<Esc>`)
   - `A` to append text at the end of each block line
   - `c` to change (delete + insert) the selected block
   - `d` to delete the selected block
   - `r<char>` to replace every selected character

### Search & Replace
| Command | Action |
|---------|--------|
| `:%s/old/new/g` | Replace all occurrences in file |
| `:%s/old/new/gc` | Replace all with confirmation |
| `:5,20s/old/new/g` | Replace in lines 5-20 |
| `:'<,'>s/old/new/g` | Replace in visual selection |

### Dot-Repeat Technique
1. `/pattern<CR>` to search for a word
2. `cgn` + type replacement + `<Esc>` (change next search match)
3. `.` to repeat on next match, `n` to skip

### LazyVim grug-far (find & replace UI)
| Key | Action |
|-----|--------|
| `<leader>sr` | Open search & replace panel |

## Windows & Splits

| Key | Mode | Action |
|-----|------|--------|
| `<C-w>v` | N | Vertical split |
| `<C-w>s` | N | Horizontal split |
| `<C-h/j/k/l>` | N | Move between splits (LazyVim) |
| `<C-w>q` | N | Close current split |
| `<C-w>=` | N | Equalize split sizes |
| `<C-w>>` / `<C-w><` | N | Increase / decrease width |

## File & Buffer Navigation (LazyVim)

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files (Telescope) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Find open buffers |
| `<leader>e` | File explorer (neo-tree) |
| `<leader>bb` | Switch buffer |
| `<leader>bd` | Close buffer |
| `[b` / `]b` | Previous / next buffer |

## Julia Workflow

### Open Julia REPL + send code

1. Open a `.jl` file
2. `<leader>tj` to open Julia REPL in a vertical split on the right
3. Write code in the left pane, send it to the REPL:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>tj` | N | Toggle Julia REPL (right split) |
| `<leader>tp` | N | Toggle Python REPL (right split) |
| `<C-\>` | N/T | Toggle generic terminal |
| `<leader>ss` | N | Send current line to REPL |
| `<leader>ss` | V | Send visual selection to REPL |
| `<leader>sp` | N | Send paragraph to REPL |
| `<leader>sb` | N | Send entire buffer to REPL |
| `<Esc>` | T | Exit terminal mode (back to normal) |

**Tip**: After `<Esc>` in terminal mode, use `i` or `a` to type in
the terminal again. Use `<C-h>` / `<C-l>` to jump between the editor
and terminal splits.

## Quarto Workflow

### Preview and run cells

| Key | Action |
|-----|--------|
| `<leader>qp` | Start Quarto preview (opens in browser) |
| `<leader>qc` | Close Quarto preview |
| `<leader>rc` | Run current code cell |
| `<leader>ra` | Run all cells above current |
| `<leader>rA` | Run all cells in document |

**Tip**: Code cells in Quarto files use ` ```{julia} ` or ` ```{python} `
fences. Navigate between cells with `]c` / `[c` if treesitter text
objects are configured.

## Soft-Wrap

| Key | Action |
|-----|--------|
| `<leader>uw` | Toggle soft-wrap on/off |

When wrap is ON, long lines display across multiple visual lines.
Use `gj` / `gk` to move by visual line (instead of `j`/`k` which
move by actual line).

Soft-wrap is **enabled by default** with word-boundary wrapping
(`linebreak`) and preserved indentation (`breakindent`).

## LSP (Code Intelligence)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Line diagnostics |
| `]d` / `[d` | Next / previous diagnostic |

## which-key

Press `<leader>` (Space) and wait — **which-key** will pop up showing
all available keybindings organized by category. This is the best way
to discover commands you've forgotten.

| Prefix | Category |
|--------|----------|
| `<leader>f` | Find / files |
| `<leader>g` | Git |
| `<leader>s` | Search / send-to-REPL |
| `<leader>b` | Buffers |
| `<leader>c` | Code actions |
| `<leader>q` | Quarto |
| `<leader>r` | Run (cells) |
| `<leader>t` | Terminal / REPL |
| `<leader>u` | UI toggles |
