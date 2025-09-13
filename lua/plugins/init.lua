return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c   = { "clang_format" },
          cpp = { "clang_format" },
          asm = { "asmfmt" }, -- optional, if you install asmfmt
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
    dev = false,
    url = "https://github.com/FelipeLema/cmp-async-path.git"
  },

  -- Debugging UI
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

      vim.api.nvim_set_keymap('n', 'e', '<Cmd>lua require("dapui").close()<CR>', { noremap = true, silent = true })
    end
  },

  -- Debugging core
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
    end
  },

  -- Mason integration for dap tools
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = { handlers = {} },
  },

  -- Mason configuration
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- C-family tools
        "clangd",
        "clang-format",
        "codelldb",
        "cpplint",

        -- Assembly tools
        "asm-lsp",
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Assembly syntax highlighting
  {
    "Shirk/vim-gas",
    ft = { "asm", "s", "S" }, -- GNU Assembly
  },

  -- Assembler linting (optional)
  {
    "dense-analysis/ale",
    ft = { "asm" },
    config = function()
      vim.g.ale_linters = {
        asm = { "gcc" }, -- use gcc for assembly linting
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

 -- Markdown file preview 
   {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({
        render_modes = { "n" }, -- render in normal mode only
      })
    end,
  },
}


}

