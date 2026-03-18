return {
  -- Ensure R treesitter parser is installed (for syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "r" } },
  },

  -- R code formatting via air (https://github.com/posit-dev/air)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        r = { "air" },
        rmd = { "air" },
      },
      formatters = {
        air = {
          command = "air",
          args = { "format", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
