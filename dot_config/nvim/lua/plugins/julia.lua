return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "julia" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          -- Use @nvim-lsp rather than Mason's julia-lsp wrapper.
          mason = false,
          cmd = {
            "julia",
            "--startup-file=no",
            "--history-file=no",
            "--project=@nvim-lsp",
            "-e",
            [[
              using LanguageServer, SymbolServer
              depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
              project_file = Base.current_project(pwd())
              project_path = project_file === nothing ?
                  dirname(Base.load_path_expand("@v#.#")) : dirname(project_file)
              server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
              server.runlinter = true
              run(server)
            ]],
          },
          filetypes = { "julia" },
        },
      },
      setup = {
        julials = function(_, opts)
          -- Returning true also excludes julials from Mason's automatic setup.
          -- Otherwise Mason replaces cmd and before_init, spawning Julia with
          -- vim.fn.system() on the editor thread to discover an environment.
          vim.lsp.config("julials", opts)
          vim.lsp.enable("julials")
          return true
        end,
      },
    },
  },
}
