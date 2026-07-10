-- Explorer
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open netrw explorer", silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window", silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window", silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", silent = true })

-- Moving lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line without losing cursor", silent = true })

-- Centered scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered", silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered", silent = true })

-- Centered searching
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered", silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered", silent = true })

-- Clear highlight
vim.keymap.set("n", "<C-c>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- Yank behavior
vim.keymap.set("n", "Y", "yy", { desc = "Yank full line" })

-- Indentation
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd("packadd nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle undo tree" })

-- Code Action
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
