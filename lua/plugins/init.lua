return {

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c   = { "clang_format" },
          cpp = { "clang_format" },
          asm = { "asmfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  -- Async path completion
  {
    "FelipeLema/cmp-async-path",
    url = "https://github.com/FelipeLema/cmp-async-path.git",
  },

  -- Debugging UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      vim.keymap.set(
        "n",
        "e",
        function() dapui.close() end,
        { noremap = true, silent = true, desc = "Close DAP UI" }
      )
    end,
  },

  -- Debugging core
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
    end,
  },

  -- Mason integration for dap tools
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },

  -- Mason configuration
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- C / C++
        "clangd",
        "clang-format",
        "codelldb",
        "cpplint",

        -- Assembly
        "asm-lsp",
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },

  -- Assembly syntax highlighting
  {
    "Shirk/vim-gas",
    ft = { "asm", "s", "S" },
  },

  -- Assembly linting
  {
    "dense-analysis/ale",
    ft = { "asm" },
    config = function()
      vim.g.ale_linters = {
        asm = { "gcc" },
      }
    end,
  },

  -- GDB frontend
  {
    "sakhnik/nvim-gdb",
    ft = { "c", "cpp", "asm" },
    build = ":!./install.sh",
    config = function()
      vim.g.nvimgdb_use_cmake_to_find_executables = 0
      vim.g.nvimgdb_disable_start_keymaps = 1
    end,
  },

  -- Markdown rendering (inline, NOT browser preview)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({
        render_modes = { "n" }, -- render only in normal mode
      })
    end,
  },

}

