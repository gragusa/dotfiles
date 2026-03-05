-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Quarto cell runner
vim.keymap.set("n", "<leader>rc", "<cmd>QuartoSend<CR>", { desc = "Run current cell" })

-- Exit terminal mode with Esc (instead of <C-\><C-n>)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
