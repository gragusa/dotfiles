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
          -- Resolve a compatible server in Julia, off the editor thread.
          mason = false,
          cmd = {
            "julia",
            "--startup-file=no",
            "--history-file=no",
            "--project=@nvim-lsp",
            vim.fn.stdpath("config") .. "/lua/julia-lsp/server.jl",
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
