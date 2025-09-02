-- ~/.config/nvim/lua/custom/plugins/conform.lua
local options = {
  formatters_by_ft = {
    lua     = { "stylua" },
    c       = { "clang_format" },
    cpp     = { "clang_format" },
    h       = { "clang_format" },
    asm = { "asmfmt" }, 
  },

  -- Format on save
  format_on_save = {
    timeout_ms = 1500,
    lsp_fallback = true,  -- use LSP formatter if available
  },
}

return options

