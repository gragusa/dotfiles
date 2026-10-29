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

### Basic movement
| Key | Mode | Action |
|-----|------|--------|
| `h/j/k/l` | N | Left / Down / Up / Right |
| `gj` / `gk` | N | Move down/up by visual line (useful with soft-wrap) |

### Word movement
| Key | Mode | Action |
|-----|------|--------|
| `w` / `b` | N | Next / previous word start |
| `e` | N | End of current/next word |
| `W` / `B` / `E` | N | Same but space-delimited (ignores punctuation) |

Any motion can be prefixed with a count: `5b` = back 5 words,
`3w` = forward 3 words, `10j` = down 10 lines.

### Line movement
| Key | Mode | Action |
|-----|------|--------|
| `0` / `$` | N | Start / end of line |
| `^` | N | First non-blank character |
| `f{char}` | N | Jump to next `{char}` on line (`F` for backward) |
| `t{char}` | N | Jump to just before next `{char}` (`T` for backward) |
| `;` / `,` | N | Repeat last `f`/`t` forward / backward |

### Screen & file movement
| Key | Mode | Action |
|-----|------|--------|
| `gg` / `G` | N | Top / bottom of file |
| `{number}G` | N | Go to line number (e.g. `42G`) |
| `{` / `}` | N | Previous / next blank line (paragraph) |
| `%` | N | Jump to matching bracket `(){}[]` |
| `<C-d>` / `<C-u>` | N | Scroll half-page down / up |
| `<C-b>` | N | Scroll full page up (`<C-d>` scrolls half a page down) |
| `H` / `M` / `L` | N | Top / middle / bottom of visible screen |

### Search
| Key | Mode | Action |
|-----|------|--------|
| `/{pattern}` | N | Search forward (`n` next, `N` previous) |
| `?{pattern}` | N | Search backward |
| `*` / `#` | N | Search word under cursor forward / backward |
| `<C-f>` / `<leader>sb` | N | Search lines in the current buffer |
| `<leader>/` / `<leader>sg` | N | Search text throughout the project |
| `<leader>sw` | N/V | Search word or selection throughout the project |
| `<leader>s.` | N | Resume the last picker |

### Flash (jump anywhere on screen)

Press `s`, type 1-2 characters — all matches highlight and you
press a label key to jump instantly. Fastest way to move anywhere visible.

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
| `<C-z>` | N/I | Undo |
| `<C-S-z>` | N/I | Redo, when supported by the terminal; otherwise Esc, Ctrl-r |
| `<leader>su` | N | Browse undo history with a diff preview; Enter restores a state |
| `U` | N | Undo all changes on current line |

Undo in Neovim is tree-based: if you undo and then make a new edit,
the old redo branch is preserved. Use `:earlier 5m` / `:later 5m` to
travel through time. `<leader>su` shows the history using the installed Snacks
picker. History persists across restarts. Edits are grouped into undo steps;
leaving Insert mode or typing punctuation creates a boundary.

## Multi-Cursor / Bulk Editing

The configuration uses multicursor.nvim, installed by Lazy on the next launch.
These mappings work in Normal and Visual mode:

| Key | Action |
|-----|--------|
| `<C-n>` / `<leader>mn` | Add a cursor at the next matching word or selection |
| `<leader>ms` | Skip a match |
| `<leader>ma` | Add cursors at all matching occurrences |
| `<leader>mj` / `<leader>mk` | Add a cursor below / above |
| `<leader>mc` | Clear extra cursors |
| `<Esc>` in Normal mode | Clear extra cursors |

Select occurrences with Ctrl-n, press `c`, type the replacement, then press
Esc twice to finish. Ctrl-n still navigates completion in Insert mode.

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
| `<leader>sr` | Replace in the current saved file |
| `<leader>sR` | Replace throughout the project |

Save first, fill in Search and Replace, inspect the results, then press Esc
and `\r` (backslash, r) to apply. `g?` shows panel commands.

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
| `<leader><space>` | Find files (Snacks picker) |
| `<leader>ff` | Find files |
| `<leader>fg` | Find Git-tracked files |
| `<leader>fb` | Find open buffers |
| `<leader>e` | File explorer (Snacks) |
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
| `<leader>rl` | N | Send current line to REPL |
| `<leader>rl` | V | Send visual selection to REPL |
| `<leader>rp` | N | Send paragraph to REPL |
| `<leader>rb` | N | Send entire buffer to REPL |
| `<Esc>` | T | Exit terminal mode (back to normal) |

**Tip**: After `<Esc>` in terminal mode, use `i` or `a` to type in
the terminal again. Use `<C-h>` / `<C-l>` to jump between the editor
and terminal splits.

## Quarto Workflow

### Preview and run cells

| Key | Action |
|-----|--------|
| `<leader>Qp` | Start Quarto preview (opens in browser) |
| `<leader>Qc` | Close Quarto preview |
| `<leader>Qf` | Format R code block under cursor (air) |
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
Uncounted `j` / `k` move by visual line in LazyVim. A count such as `3j`
moves by actual lines. `gj` / `gk` explicitly move by visual line.

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
| `<leader>s` | Search / replace |
| `<leader>m` | Multiple cursors |
| `<leader>b` | Buffers |
| `<leader>c` | Code actions |
| `<leader>q` | Quit / session |
| `<leader>Q` | Quarto preview / formatting |
| `<leader>r` | Run cells / send to REPL |
| `<leader>t` | Terminal / REPL |
| `<leader>u` | UI toggles |
