local cmp = require("cmp")

-- Fortran buffer-specific completion setup
cmp.setup.buffer {
    sources = {
        { name = "nvim_lsp" },  -- Only load LSP for Fortran
        { name = "buffer" },
        { name = "path" },
    }
}

-- Fortran Language Server (fortls)
local lspconfig = require('lspconfig')

lspconfig.fortls.setup {
    cmd = { "fortls" },
    filetypes = { "fortran", "f90", "f95", "f03", "f08", "f" },  -- Fortran file extensions
}

