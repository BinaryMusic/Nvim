local options = {
  ensure_installed = { "lua", "vim", "vimdoc", "python" },  -- List of languages to ensure parsers are installed for

  highlight = {
    enable = true,  -- Enable Treesitter-based highlighting
    use_languagetree = true,  -- Use the language tree for highlighting
  },

  indent = { enable = true },  -- Enable Treesitter-based indentation
}

return options

