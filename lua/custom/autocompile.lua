local M = {}

-- Function to compile files based on their type
M.compile_file = function()
    local ft = vim.bo.filetype
    local file = vim.fn.expand("%") -- Current file name

    if ft == "python" then
        -- Run Python file in terminal
        vim.cmd("split | terminal python3 " .. file)
    elseif ft == "c" then
        -- For C files, use gcc in terminal
        local output = file:gsub("%.%w+$", "") -- Remove file extension
        vim.cmd("split | terminal gcc -o " .. output .. " " .. file)
    elseif ft == "cpp" then
        -- For C++ files, use g++ in terminal
        local output = file:gsub("%.%w+$", "") -- Remove file extension
        vim.cmd("split | terminal g++ -o " .. output .. " " .. file)
    elseif ft == "fortran" then
        -- For Fortran files, use gfortran in terminal
        local output = file:gsub("%.%w+$", "") -- Remove file extension
        vim.cmd("split | terminal gfortran -o " .. output .. " " .. file)
    elseif ft == "tex" then
        -- Use vimtex to compile LaTeX files
        vim.cmd("VimtexCompile")
    else
        print("No compilation setup for filetype: " .. ft)
    end
end

return M

