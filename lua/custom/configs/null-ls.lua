local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Setup null-ls
null_ls.setup({
  sources = {
    -- C-family sources
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.cpplint,

    -- Python sources
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy,

    -- Fortran sources
    null_ls.builtins.formatting.fprettify,
  },
  on_attach = function(client, bufnr)
    -- Set up formatting on save for clients that support it
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- Notify when formatting is triggered
          vim.notify("Formatting on save triggered", vim.log.levels.INFO)
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

-- Notify user about the configuration
vim.notify("C-family, Python, and Fortran are fully configured with formatting and diagnostics.", vim.log.levels.INFO)

