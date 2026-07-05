-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlightyank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
