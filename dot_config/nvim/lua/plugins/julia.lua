return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          cmd = {
            "julia",
            "--startup-file=no",
            "--history-file=no",
            "--project=@nvim-lsp",
            "-e",
            [[
              using LanguageServer, SymbolServer
              depot_path = get(ENV, "JULIA_DEPOT_PATH", joinpath(homedir(), ".julia"))
              server = LanguageServer.LanguageServerInstance(stdin, stdout, false, depot_path)
              server.runlinter = true
              run(server)
            ]],
          },
          filetypes = { "julia" },
        },
      },
    },
  },
}
