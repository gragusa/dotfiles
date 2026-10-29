return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        julia = { "juliaformatter" },
        r = { "styler" },
        typst = { "injected" },
      },
      formatters = {
        juliaformatter = {
          command = "julia",
          args = {
            "--startup-file=no",
            "--project=@nvim-lsp",
            "-e",
            [[
              using JuliaFormatter
              print(format_text(read(stdin, String)))
            ]],
          },
          stdin = true,
        },
        styler = {
          command = "Rscript",
          args = {
            "-e",
            [[
              con <- file("stdin")
              code <- readLines(con)
              close(con)
              styled <- styler::style_text(code)
              cat(styled, sep = "\n")
            ]],
          },
          stdin = true,
        },
      },
    },
  },
}
