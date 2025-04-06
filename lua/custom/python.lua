local cmp = require("cmp")

-- Python buffer-specific completion setup
cmp.setup.buffer {
    sources = {
        { name = "nvim_lsp" },  -- Load LSP for Python
        { name = "buffer" },
        { name = "path" },
    }
}

-- Python Language Server (assuming you are using `pyright` for example)
local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
    cmd = { "pyright" },  -- Replace with your preferred Python language server
    filetypes = { "python" },
}

