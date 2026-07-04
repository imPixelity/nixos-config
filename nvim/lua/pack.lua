local gh = function(x) return "https://github.com/" .. x end
local cb = function(x) return "https://codeberg.org/" .. x end

vim.pack.add({
    { src = gh("ayu-theme/ayu-vim") },
    { src = gh("nvim-mini/mini.nvim") },
})

require("mini.files").setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H",
    },
    windows = {
        preview = true,
    },
})

vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>E", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "Toggle mini file explorer to current opened file" })
