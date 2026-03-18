-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
