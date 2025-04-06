-- Settings related to Python files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        require("custom.python")
    end,
})

-- Settings related to C family files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    callback = function()
        require("custom.c_family")
    end,
})

-- Settings related to Fortran files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "fortran", "f90", "f95", "f03", "f08", "f" }, 
    callback = function()
        require("custom.fortran")
    end,
})

-- Settings related to .tex files (LaTeX)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        require("custom.tex")
    end,
})

