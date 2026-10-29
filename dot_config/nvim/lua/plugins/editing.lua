return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          local path = vim.api.nvim_buf_get_name(0)
          if vim.bo.buftype ~= "" or path == "" or vim.fn.filereadable(path) ~= 1 then
            vim.notify("Save this file before opening search and replace", vim.log.levels.WARN)
            return
          end
          require("grug-far").open({
            transient = true,
            prefills = { paths = vim.fn.fnameescape(path) },
          })
        end,
        mode = { "n", "x" },
        desc = "Replace in current file",
      },
      {
        "<leader>sR",
        function()
          require("grug-far").open({
            transient = true,
            prefills = { paths = vim.fn.fnameescape(LazyVim.root()) },
          })
        end,
        mode = { "n", "x" },
        desc = "Replace in project",
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sR", false }, -- reserved for project replacement
      {
        "<leader>s.",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume last search",
      },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
      {
        "<C-n>",
        function()
          require("multicursor-nvim").matchAddCursor(1)
        end,
        mode = { "n", "x" },
        desc = "Add cursor at next match",
      },
      {
        "<leader>mn",
        function()
          require("multicursor-nvim").matchAddCursor(1)
        end,
        mode = { "n", "x" },
        desc = "Add cursor at next match",
      },
      {
        "<leader>ms",
        function()
          require("multicursor-nvim").matchSkipCursor(1)
        end,
        mode = { "n", "x" },
        desc = "Skip match",
      },
      {
        "<leader>ma",
        function()
          require("multicursor-nvim").matchAllAddCursors()
        end,
        mode = { "n", "x" },
        desc = "Add cursors at all matches",
      },
      {
        "<leader>mj",
        function()
          require("multicursor-nvim").lineAddCursor(1)
        end,
        mode = { "n", "x" },
        desc = "Add cursor below",
      },
      {
        "<leader>mk",
        function()
          require("multicursor-nvim").lineAddCursor(-1)
        end,
        mode = { "n", "x" },
        desc = "Add cursor above",
      },
      {
        "<leader>mc",
        function()
          require("multicursor-nvim").clearCursors()
        end,
        mode = { "n", "x" },
        desc = "Clear extra cursors",
      },
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      mc.addKeymapLayer(function(set)
        set("n", "<Esc>", function()
          mc.clearCursors()
          vim.cmd.nohlsearch()
        end)
      end)
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "multiple cursors", mode = { "n", "x" } },
        { "<leader>r", group = "run / REPL", mode = { "n", "x" } },
      },
    },
  },
}
