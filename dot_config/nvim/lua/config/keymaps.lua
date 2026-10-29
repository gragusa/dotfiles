-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Native undo is u; native redo is Ctrl-r. These aliases also work while typing.
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-g>u<C-o>u", { desc = "Undo" })
vim.keymap.set("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
vim.keymap.set("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo" })

-- Search mappings live under <leader>s; REPL mappings live under <leader>r.
vim.keymap.set("n", "<C-f>", function()
  Snacks.picker.lines()
end, { desc = "Find in current buffer" })

-- Quarto cell runner
vim.keymap.set("n", "<leader>rc", "<cmd>QuartoSend<CR>", { desc = "Run current cell" })

-- Exit terminal mode with Esc (instead of <C-\><C-n>)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle soft-wrap on/off
vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("Wrap: " .. (vim.wo.wrap and "ON" or "OFF"))
end, { desc = "Toggle word wrap" })

-- Quarto: run all cells above
vim.keymap.set("n", "<leader>ra", "<cmd>QuartoSendAbove<CR>", { desc = "Run all cells above" })

-- Quarto: run all cells
vim.keymap.set("n", "<leader>rA", "<cmd>QuartoSendAll<CR>", { desc = "Run all cells" })
