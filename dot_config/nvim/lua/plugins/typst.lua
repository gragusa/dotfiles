return {
  -- Typst preview
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    build = function()
      require("typst-preview").update()
    end,
    keys = {
      { "<leader>tp", "<cmd>TypstPreview<cr>", desc = "Typst preview" },
      { "<leader>ts", "<cmd>TypstPreviewStop<cr>", desc = "Typst preview stop" },
    },
    opts = {},
  },

  -- Ensure typst treesitter parser is installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },

  -- Otter for embedded language support in typst files
  {
    "jmbuhr/otter.nvim",
    ft = "typst",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local otter = require("otter")

      -- Activate otter for typst files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "typst",
        callback = function()
          otter.activate({ "julia", "r", "python" }, true, true, nil)
        end,
      })
    end,
  },
}
