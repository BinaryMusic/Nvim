local base = require("plugins.configs.lspconfig")
local on_attach_base = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

-- Define all servers and their configurations in a structured table
local servers = {
  clangd = {
    setup = {
      on_attach = function(client, bufnr)
        -- Disable signatureHelpProvider if not required
        client.server_capabilities.signatureHelpProvider = false
        on_attach_base(client, bufnr)
      end,
      capabilities = capabilities,
    },
  },
  pyright = {
    setup = {
      on_attach = on_attach_base,
      capabilities = capabilities,
      filetypes = {"python"},
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict",  -- Stricter type checking for Pyright
            diagnosticMode = "workspace", -- or "openFilesOnly"
          },
        },
      },
    },
  },
  ruff_lsp = {
    setup = {
      on_attach = on_attach_base,
      capabilities = capabilities,
      filetypes = {"python"},
      settings = {
        ruff = {
          linting = {
            enabled = true,
            extendSelect = {"E", "W", "F"},  -- Enabling specific linting categories
          },
        },
      },
    },
  },
  fortls = {
    setup = {
      on_attach = on_attach_base,
      capabilities = capabilities,
      filetypes = {"fortran", "f90", "f95", "f03", "f08"},
      settings = {
        fortls = {
           linting = {
            enabled = true,
            extendSelect = {"E", "W", "F"},  -- Enabling specific linting categories
          },

          
        },
      },
    },
  },
  -- Add more language servers here
}

-- Iterate over the servers table to set up each server with its respective configuration
for lsp, config in pairs(servers) do
  lspconfig[lsp].setup(config.setup)
end

