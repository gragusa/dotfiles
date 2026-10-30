local function latex_reference_sources()
  -- The installed LaTeX parser recognizes empty and multiline key arguments.
  vim.treesitter.get_parser(0, "latex"):parse()
  local node = vim.treesitter.get_node({ lang = "latex", ignore_injections = true })
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  while node do
    local kind = node:type()
    if kind == "curly_group_text_list" or kind == "curly_group_label_list" or kind == "curly_group_label" then
      local parent = node:parent()
      local command = parent and parent:type()
      if command == "citation" or command == "label_reference" or command == "label_reference_range" then
        local end_row, end_col = node:end_()
        local closing = node:child(node:child_count() - 1)
        if row < end_row or col < end_col or (closing and closing:missing()) then
          return { "latex_references" }
        end
      end
    end
    node = node:parent()
  end
  return {}
end

return {
  {
    "lervag/vimtex",
    init = function()
      -- Keep commands, math delimiters, and citation syntax visible.
      vim.g.vimtex_syntax_conceal_disable = 1
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-j>"] = { "show", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
      },
      sources = {
        per_filetype = {
          tex = latex_reference_sources,
          plaintex = latex_reference_sources,
        },
        providers = {
          latex_references = {
            name = "Citations and references",
            module = "blink.cmp.sources.lsp",
            fallbacks = {},
          },
        },
      },
      completion = {
        ghost_text = {
          enabled = function()
            return vim.g.ai_cmp and vim.bo.filetype ~= "tex" and vim.bo.filetype ~= "plaintex"
          end,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
              },
              forwardSearch = {
                executable = "open",  -- macOS: opens in default PDF viewer
                args = { "%p" },
              },
            },
          },
        },
      },
    },
  },
}
