return {
  -- R code formatting via styler
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        r = { "styler" },
        rmd = { "styler" },
      },
      formatters = {
        styler = {
          command = "Rscript",
          args = {
            "-e",
            "con <- file('stdin'); code <- readLines(con); close(con); styled <- styler::style_text(code); cat(styled, sep='\\n')",
          },
          stdin = true,
        },
      },
    },
  },
}
