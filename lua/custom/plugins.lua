local plugins = {

  -- Plugin for color configuration
  {
    "morhetz/gruvbox"
  },

   -- VimTeX plugin for LaTeX support
  {
    "lervag/vimtex",
    ft = "tex",  -- Load only for .tex files
    config = function()
      -- Use latexmk for compilation
      vim.g.vimtex_compiler_method = "latexmk"   -- Use latexmk for compilation
      vim.g.tex_flavor = "latex"                 -- Set LaTeX as the default flavor

      -- Set the PDF viewer as zathura
      vim.g.vimtex_view_general_viewer = 'zathura'

      -- Use system PDF viewer (zathura)
      vim.g.vimtex_view_method = 'general'        -- View with external viewer (zathura)

      -- Disable default mappings
      vim.g.vimtex_mappings_enabled = false

      -- Indentation settings (optional)
      vim.g.vimtex_indent_enabled = false        -- Disable auto-indent from Vimtex
      vim.g.tex_indent_items = false             -- Disable indent for enumerate
      vim.g.tex_indent_brace = false             -- Disable brace indent

      -- Suppression settings
      vim.g.vimtex_quickfix_mode = 0             -- Suppress quickfix on save/build
      vim.g.vimtex_log_ignore = {                -- Suppress specific log messages
        'Underfull',
        'Overfull',
        'specifier changed to',
        'Token not allowed in a PDF string',
      }
    end,
  },

  -- Dependency for nvim-dap-ui (applies to both C-family and Python)
  {
    "nvim-neotest/nvim-nio",
    -- No additional configuration needed here
  },

  -- nvim-dap and nvim-dap-ui for debugging (shared for both C-family and Python)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Key mappings for debugging, ensure no conflicts between languages
      vim.api.nvim_set_keymap('n', 'e', '<Cmd>lua require("dapui").close()<CR>', { noremap = true, silent = true })
    end
  },

  -- nvim-dap setup (shared for both C-family and Python)
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      -- Key mappings for general DAP usage
      require("core.utils").load_mappings("dap")
    end
  },

  -- Mason integration for dap tools (shared)
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },

  -- Mason configuration for C-family and Python tools (add Fortran tools)
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- C-family tools
        "clangd",      -- Language server for C, C++, Objective-C
        "clang-format", -- Code formatter for C-family languages
        "codelldb",     -- Debugger for C-family languages
        "cpplint",     -- Static analysis tool for C/C++
        
        -- Python tools
        "black",        -- Python code formatter
        "debugpy",      -- Debugger for Python
        "mypy",         -- Python linter
        "ruff-lsp",     -- Python linter
        "pyright",      -- Python language server
        -- Fortran tools
        "fortls",       -- Fortran language server
        "fprettify",    -- Fortran code formatter
      },
    },
  },

 
  -- nvim-dap-python for Python debugging (only loaded for Python)
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },

  
    -- LSP configuration (shared, with specific support for Python, C-family, and Fortran)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },


  -- null-ls configuration for linting and formatting for C-family, Python, and Fortran
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "LspAttach",  -- Ensures this runs when LSP attaches
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- C-family sources
          null_ls.builtins.formatting.clang_format,  -- C-family formatter
      
          null_ls.builtins.diagnostics.cpplint,     -- C/C++ static analysis

          -- Python sources
          null_ls.builtins.formatting.black,         -- Python formatter
          null_ls.builtins.diagnostics.mypy,        -- Python linter
          null_ls.builtins.diagnostics.ruff,        -- Python linter
          

          -- Fortran sources
          null_ls.builtins.formatting.fprettify,    -- Fortran formatter
        }
      }
    end,
  },
}

return plugins

