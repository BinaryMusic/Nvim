-- ~/.config/nvim/lua/custom/configs/lspconfig.lua
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require("lspconfig/util")

-- Enhanced capabilities with snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- List every LSP you want enabled
local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=never",
      "--completion-style=detailed",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = util.root_pattern("compile_commands.json", ".git"),
    capabilities = capabilities,
  },
  
  fortls = {
    filetypes = { "fortran" },
    cmd = { "fortls", "--lowercase_intrinsics" },
    root_dir = util.root_pattern(".git", "Makefile"),
  },

  ruff = {
    filetypes = { "python" },
    single_file_support = true,
  },

  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "strict",
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
    capabilities = capabilities,
  },
}

-- Common on_attach function for all LSP servers
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Keymaps
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)

  -- Set up diagnostics
  vim.diagnostic.config({
    virtual_text = {
      prefix = '■',
      format = function(diagnostic)
        return string.format("%s (%s: %s)", 
          diagnostic.message, 
          diagnostic.source, 
          diagnostic.code or "")
      end,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Show line diagnostics automatically in hover window
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
      })
    end
  })
end

-- Loop through the table and set each server up
for name, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, opts or {})

  lspconfig[name].setup(opts)
end

-- Additional LSP configuration
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
