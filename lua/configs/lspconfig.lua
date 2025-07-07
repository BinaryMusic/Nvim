-- ~/.config/nvim/lua/custom/configs/lspconfig.lua
local lspconfig = require("lspconfig")

-- List every LSP you want enabled.
local servers = {
  clangd   = {},
  fortls   = {},
  ruff = {},

  -- Pyright with a tiny bit of config
  pyright  = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "strict",
        },
      },
    },
  },

  -- Add more servers if you need them, e.g.:
  -- html   = {},
  -- cssls  = {},
}

-- Loop through the table and set each server up
for name, opts in pairs(servers) do
  lspconfig[name].setup(opts)
end

