local cmp = require("cmp")

-- c_family buffer-specific completion setup
cmp.setup.buffer {
    sources = {
        { name = "nvim_lsp" },  -- Only load LSP for c_family
        { name = "buffer" },
        { name = "path" },
    }
}

-- c_family Language Server (clang-format)
local lspconfig = require('lspconfig')

lspconfig.clangd.setup {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc" },  -- c_family  file extensions
}


