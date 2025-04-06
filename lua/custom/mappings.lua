local M = {}

-- General DAP key mappings
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle Breakpoint" -- Description for the key mapping
    },
    ["<leader>dc"] = {
      "<cmd> DapContinue <CR>",
      "Continue Debugging" -- Additional key mapping for 'continue'
    }
  }
}

-- Python-specific DAP key mappings (dap-python)
M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      "<cmd>lua require('dap-python').test_method()<CR>",
      "Test Method" -- Description for 'test_method'
    },
    ["<leader>dpc"] = {
      "<cmd>lua require('dap-python').test_class()<CR>",
      "Test Class" -- Optional: Test the current class
    }
  }
}

return M

