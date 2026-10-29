return {
  -- ── toggleterm: manage persistent terminal panes ──
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", desc = "Toggle terminal" },
      { "<leader>tp", desc = "Python REPL" },
      { "<leader>tj", desc = "Julia REPL" },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
        open_mapping = "<C-\\>",
        direction = "vertical", -- side-by-side: code left, REPL right
        shade_terminals = true,
        persist_size = true,
        persist_mode = true,
      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- Dedicated Python REPL
      local python = Terminal:new({
        cmd = "python3",
        direction = "vertical",
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
          -- allow <C-\\> to toggle from inside the terminal too
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      -- Dedicated Julia REPL
      local julia = Terminal:new({
        cmd = "julia",
        direction = "vertical",
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      vim.keymap.set("n", "<leader>tp", function()
        python:toggle()
      end, { desc = "Toggle Python REPL" })
      vim.keymap.set("n", "<leader>tj", function()
        julia:toggle()
      end, { desc = "Toggle Julia REPL" })
    end,
  },

  -- ── vim-slime: send code from editor to terminal ──
  {
    "jpalardy/vim-slime",
    cmd = { "SlimeSend", "SlimeSendCurrentLine", "SlimeConfig" },
    keys = {
      { "<leader>rl", mode = { "n", "x" }, desc = "Send line / selection to REPL" },
      { "<leader>rb", desc = "Send buffer to REPL" },
      { "<leader>rp", desc = "Send paragraph to REPL" },
    },
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true -- we define our own below
      -- Don't prompt for config — auto-detect the last terminal
      vim.g.slime_dont_ask_default = true
      vim.api.nvim_create_autocmd("TermEnter", {
        group = vim.api.nvim_create_augroup("repl_slime_target", { clear = true }),
        callback = function()
          vim.g.slime_default_config = { jobid = vim.b.terminal_job_id }
        end,
      })
    end,
    config = function()
      -- Helper: find the most recently opened terminal buffer (toggleterm channel)
      local function last_terminal_chan()
        local buffers = vim.api.nvim_list_bufs()
        for i = #buffers, 1, -1 do
          local buf = buffers[i]
          if vim.bo[buf].buftype == "terminal" then
            local chan = vim.b[buf].terminal_job_id
            if chan then
              return chan
            end
          end
        end
        return nil
      end

      -- Keep <leader>s available for search.
      vim.keymap.set("n", "<leader>rl", function()
        if not vim.g.slime_default_config then
          local chan = last_terminal_chan()
          if chan then
            vim.g.slime_default_config = { jobid = chan }
          end
        end
        vim.cmd("SlimeSendCurrentLine")
      end, { desc = "Send line to REPL" })

      vim.keymap.set("x", "<leader>rl", function()
        if not vim.g.slime_default_config then
          local chan = last_terminal_chan()
          if chan then
            vim.g.slime_default_config = { jobid = chan }
          end
        end
        vim.cmd("'<,'>SlimeSend")
      end, { desc = "Send selection to REPL" })

      vim.keymap.set("n", "<leader>rb", function()
        if not vim.g.slime_default_config then
          local chan = last_terminal_chan()
          if chan then
            vim.g.slime_default_config = { jobid = chan }
          end
        end
        vim.cmd("%SlimeSend")
      end, { desc = "Send buffer to REPL" })

      vim.keymap.set("n", "<leader>rp", function()
        if not vim.g.slime_default_config then
          local chan = last_terminal_chan()
          if chan then
            vim.g.slime_default_config = { jobid = chan }
          end
        end
        vim.api.nvim_feedkeys(vim.keycode("<Plug>SlimeParagraphSend"), "m", false)
      end, { desc = "Send paragraph to REPL" })
    end,
  },
}
