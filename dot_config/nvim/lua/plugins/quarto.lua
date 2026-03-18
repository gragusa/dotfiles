return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        opts = {},
      },
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

      -- Format current code block in a Quarto/markdown file using otter
      vim.keymap.set("n", "<leader>cf", function()
        local ft = vim.bo.filetype
        if ft == "quarto" or ft == "markdown" then
          require("otter").ask_format()
        else
          require("conform").format({ async = true, lsp_fallback = true })
        end
      end, { desc = "Format (otter in quarto, conform elsewhere)" })
    end,
  },
}
