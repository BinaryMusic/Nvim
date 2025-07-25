return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- format on save
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- C-family
          c = { "clang_format" },
          cpp = { "clang_format" },
          
          -- Python
          python = { "black", "ruff" },
          
          -- Fortran
          fortran = { "fprettify" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
{
    "nvim-tree/nvim-web-devicons",
    lazy = true,  -- Load when needed (recommended)
    opts = {},    -- Default configuration (or customize)
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)  -- Explicit setup call
    end,
  },  
  {
    "FelipeLema/cmp-async-path",
    dev = false,
    url = "https://github.com/FelipeLema/cmp-async-path.git"
  },
  
  -- VimTeX plugin for LaTeX support
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_general_viewer = 'zathura'
      vim.g.vimtex_view_method = 'general'
      vim.g.vimtex_mappings_enabled = false
      vim.g.vimtex_indent_enabled = false
      vim.g.tex_indent_items = false
      vim.g.tex_indent_brace = false
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_log_ignore = {
        'Underfull',
        'Overfull',
        'specifier changed to',
        'Token not allowed in a PDF string',
      }
    end,
  },

  -- Dependency for nvim-dap-ui
  {
    "nvim-neotest/nvim-nio",
  },

  -- nvim-dap and nvim-dap-ui for debugging
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
    opts = {
      handlers = {}
    },
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
        
        -- Python tools
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
        
        -- Fortran tools
        "fortls",
        "fprettify",
      },
    },
  },

  -- nvim-dap-python for Python debugging
 {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)
    
    -- Manually set keybindings (no core.utils dependency)
    vim.keymap.set("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>")
    vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>")
  end,
}, 
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- here is configs for jupyter like environment for python 
{
'Vigemus/iron.nvim',
ft = { "python" }, -- Load only for these file types
config = function()
local iron = require("iron.core")

iron.setup({
  config = {
    scratch_repl = true, -- Allow discarding REPLs
    repl_definition = {
      python = { command = { "ipython" } }
    },
    repl_open_cmd = require("iron.view").right(vim.o.columns * 0.4), -- Dynamic width
  },
  keymaps = {
    send_motion = "<space>rc",
    visual_send = "<space>rc",
    send_file = "<space>rf",
    send_line = "<space>rl",
    send_mark = "<space>rm",
    mark_motion = "<space>rmc",
    mark_visual = "<space>rmc",
    remove_mark = "<space>rmd",
    cr = "<space>r<cr>",
    interrupt = "<space>r<space>",
    exit = "<space>rq",
    clear = "<space>rx",
    send_paragraph = "<space>rp", -- Custom keymap to send a paragraph
  },
  highlight = {
    italic = true,
    fg = "#A9A1E1", -- Optional custom foreground
    bg = "#2E3440", -- Optional custom background
  },
  ignore_blank_lines = true,
})

-- Additional keymaps for REPL management
vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
vim.keymap.set("n", "<space>rF", "<cmd>IronFocus<cr>")
vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
vim.keymap.set("n", "<space>rc", "<cmd>IronClear<cr>") -- Clear REPL
end,
},}
