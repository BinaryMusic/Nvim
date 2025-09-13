require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>")

-- Toggle Markdown Preview (GitHub-like view)
map("n", "<leader>mp", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Preview" })


-- Replace Down arrow functionality
map({ "n", "i", "v" }, "<A-j>", "<Down>", { desc = "Move down (alt+j instead of down key)" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
