-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Soft-wrap: enabled by default for prose-heavy files
vim.opt.wrap = true -- enable visual line wrapping
vim.opt.linebreak = true -- wrap at word boundaries, not mid-word
vim.opt.breakindent = true -- preserve indentation in wrapped lines

-- Keep editing history across restarts and preview substitutions while typing.
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Avoid animated scrolling while waiting for the cursor to settle.
vim.g.snacks_animate = false
