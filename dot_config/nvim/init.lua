vim.g.python3_host_prog = vim.fn.expand("~/.venv/nvim/bin/python")

-- Set provider paths before plugins can request them.
require("config.lazy")
