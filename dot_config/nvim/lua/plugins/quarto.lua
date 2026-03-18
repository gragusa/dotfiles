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

      -- Format current code block in a Quarto file
      -- Selects the code inside the fence and pipes through styler
      vim.keymap.set("n", "<leader>qf", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] -- 1-indexed
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        -- Find the code fence boundaries around cursor
        local fence_start, fence_end, lang
        for i = row, 1, -1 do
          local m = lines[i]:match("^```%s*{(%w+)}")
          if m then
            fence_start = i
            lang = m
            break
          end
          if lines[i]:match("^```%s*$") and i < row then
            break -- hit a closing fence above us, not inside a block
          end
        end
        if not fence_start then
          vim.notify("Not inside a code block", vim.log.levels.WARN)
          return
        end
        for i = fence_start + 1, #lines do
          if lines[i]:match("^```%s*$") then
            fence_end = i
            break
          end
        end
        if not fence_end then
          vim.notify("Could not find closing fence", vim.log.levels.WARN)
          return
        end

        -- Extract code lines (between fences, exclusive)
        local code_lines = {}
        for i = fence_start + 1, fence_end - 1 do
          table.insert(code_lines, lines[i])
        end
        if #code_lines == 0 then return end

        -- Format via temp file (air doesn't support stdin)
        if lang ~= "r" and lang ~= "R" then
          vim.notify("No formatter configured for {" .. lang .. "}", vim.log.levels.INFO)
          return
        end

        local tmpfile = vim.fn.tempname() .. ".R"
        vim.fn.writefile(code_lines, tmpfile)
        vim.fn.system({ "air", "format", tmpfile })
        if vim.v.shell_error ~= 0 then
          vim.notify("air format failed", vim.log.levels.ERROR)
          os.remove(tmpfile)
          return
        end

        local new_lines = vim.fn.readfile(tmpfile)
        os.remove(tmpfile)

        -- Remove trailing empty lines from formatter output
        while #new_lines > 0 and new_lines[#new_lines] == "" do
          table.remove(new_lines)
        end

        vim.api.nvim_buf_set_lines(bufnr, fence_start, fence_end - 1, false, new_lines)
        vim.notify("Formatted {" .. lang .. "} block", vim.log.levels.INFO)
      end, { desc = "Format current code block" })
    end,
  },
}
