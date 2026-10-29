# Neovim configuration

LazyVim with Julia, R, Quarto, LaTeX, and Typst support. The leader key is
**Space**. Press **Esc** to enter Normal mode before using the shortcuts below;
pause after Space to see the available commands.

## Undo and redo

| Shortcut | Action |
| --- | --- |
| `u` | Undo the last edit in Normal mode |
| `Ctrl-r` | Redo in Normal mode |
| `Ctrl-z` | Undo in Normal or Insert mode |
| `Ctrl-Shift-z` | Redo, if the terminal distinguishes this key from Ctrl-z |
| `Space s u` | Browse undo history with a diff preview; Enter restores the selected state |

Undo works on groups of edits, such as an Insert-mode session. LazyVim adds
undo boundaries after commas, periods, and semicolons. History persists after
saving and restarting Neovim. If Ctrl-Shift-z is unavailable, use Esc, Ctrl-r.
Ctrl-z now undoes instead of suspending Neovim; `:suspend` still suspends it.

## Search and navigation

| Shortcut | Action |
| --- | --- |
| `/text`, then Enter | Search the current file; `n` / `N` move forward / backward |
| `*` | Search for the word under the cursor |
| `Ctrl-f` or `Space s b` | Search lines in the current buffer with a preview |
| `Space /` or `Space s g` | Search text throughout the project |
| `Space s w` | Search the current word or visual selection throughout the project |
| `Space Space` | Find a file by name |
| `Space s .` | Resume the last picker |
| `s` | Flash: type part of the target, then its displayed label to jump |
| `Esc` | Clear search highlighting |

[Flash](https://github.com/folke/flash.nvim) provides jumps like vim-sneak or
vim-snipe and is already part of LazyVim. Project search uses ripgrep through
the Snacks picker. In a picker, type to filter, use Ctrl-n / Ctrl-p to move,
Enter to open, and Esc to leave Insert mode, then Esc again to close it.

## Search and replace

| Shortcut | Action |
| --- | --- |
| `Space s r` | Open the replacement panel for the current saved file |
| `Space s R` | Open the replacement panel for the project |
| `:%s/old/new/gc` | Replace in the current buffer, confirming each match |

Save your work first with Ctrl-s. In the
[grug-far panel](https://github.com/MagicDuck/grug-far.nvim), edit **Search** and
**Replace**, using Tab / Shift-Tab to switch fields in Normal mode. Inspect the
matching lines, then press **Esc**, **backslash**, **r** to apply the replacement.
The local leader is backslash, so this is `\r`, not Space r. Press `g?` in the
panel for its commands. A visual selection prefills the search when opening
either panel. Search patterns use ripgrep's regular expressions.

For the built-in `:%s/old/new/gc` command, `g` means every occurrence on each
line and `c` asks for confirmation. Answer `y`, `n`, `a` (all remaining), or `q`.
The replacement preview updates as you type. `u` undoes a buffer replacement;
replacements across files must be undone separately in each affected buffer.

## Multiple cursors

[multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim) loads on its
first shortcut. Lazy installs it on the next launch; this first installation
requires internet access.

| Shortcut | Action, in Normal or Visual mode |
| --- | --- |
| `Ctrl-n` or `Space m n` | Add a cursor at the next matching word or selection |
| `Space m s` | Skip the next match |
| `Space m a` | Add cursors at all matches in the buffer |
| `Space m j` / `Space m k` | Add a cursor below / above |
| `Space m c` | Clear the extra cursors |
| `Esc` in Normal mode | Clear the extra cursors |

For example, put the cursor on a variable and press Ctrl-n repeatedly to choose
occurrences. Press `c`, type the replacement, then Esc to leave Insert mode and
Esc again to clear the extra cursors. Normal Vim editing commands operate at
all active cursors. Ctrl-n retains its completion behavior in Insert mode.

## REPL and document shortcuts

Code sending uses `Space r`, leaving `Space s` available for search.

| Shortcut | Action |
| --- | --- |
| `Space t p` | Toggle the Python REPL; in Typst buffers, preview the document |
| `Space t j` | Toggle the Julia REPL |
| `Ctrl-\` | Toggle the terminal |
| `Esc` in a terminal | Return to Normal mode |
| `Space r l` | Send the current line or visual selection to the REPL |
| `Space r b` | Send the entire buffer to the REPL |
| `Space r p` | Send the paragraph to the REPL |
| `Space r c` | Run the current Quarto cell |
| `Space r a` / `Space r A` | Run Quarto cells above / all cells |

The old `Space s s`, `Space s b`, and `Space s p` code-sending mappings are now
`Space r l`, `Space r b`, and `Space r p`.

## Startup

Two Julia startup stalls are addressed:

- `queries/julia/textobjects.scm` overrides the upstream query and separates
  expensive conditional patterns while retaining syntax-aware text objects.
- `lua/plugins/julia.lua` excludes the custom Julia server from Mason's
  automatic setup, which otherwise replaces its command and synchronously
  starts Julia to discover the environment. Project discovery now runs inside
  the language-server process.

Tabnine and its compatibility layer load with completion. Slime loads when
needed by a command, shortcut, or Quarto. Scrolling animations and automatic
plugin update checks are disabled. Use `:Lazy check` to check for updates and
`:Lazy profile` to inspect plugin loading. VimTeX still loads at startup to
support inverse search.

## Julia language server

The launcher at `lua/julia-lsp/server.jl` uses the `@nvim-lsp` environment when
it contains a compatible server. On Julia 1.13 and newer, it requires
LanguageServer 6 or newer: the older SymbolServer dependency can fail during
precompilation. If the dedicated environment is outdated, the launcher uses
the compatible server bundled with an installed VS Code Julia extension.
All discovery and server loading happen in the Julia process.
The first launch builds server and indexing caches in the background; language
features become available after that setup, while editing remains responsive.

Set `NVIM_JULIA_LSP_PROJECT` to a project directory or named environment to
choose the server environment explicitly. Missing or incompatible packages
produce an error. The launcher uses LanguageServer's public `runserver()` API
to select and analyze the edited project's environment.
