return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          languages = { "python", "julia", "bash", "r" },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime",
        },
      })
      vim.keymap.set("n", "<leader>qp", function()
        require("quarto").quartoPreview()
      end, { silent = true, noremap = true, desc = "Quarto preview" })
    end,
  },
}
