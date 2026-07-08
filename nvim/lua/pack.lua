vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/RRethy/base16-nvim" },
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

require("mini.ai").setup()
require("mini.align").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()

local MiniFiles = require("mini.files")
MiniFiles.setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H",
    },
})

vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end,
    { desc = "Toggle mini file explorer to current opened file" })

require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

require("mini.cmdline").setup({
    autocorrect = { enable = false },
})


local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>ff", function() MiniPick.builtin.files() end, { desc = "Mini file picker" })
vim.keymap.set("n", "<leader>fg", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Mini grep" })
vim.keymap.set("n", "<leader>h", function() MiniPick.builtin.help() end, { desc = "Mini help" })
vim.keymap.set("n", "<leader>fb", function() MiniPick.builtin.buffers() end, { desc = "Mini buffers" })

vim.keymap.set("n", "<leader>fd", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini picker diagnostic" })
vim.keymap.set("n", "<leader>k", function() MiniExtra.pickers.keymaps() end, { desc = "Mini picker keymaps" })
vim.keymap.set("n", "<leader>gh", function() MiniExtra.pickers.git_hunks() end, { desc = "Mini picker git hunks" })

require("mini.completion").setup()

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(),
    },
})
MiniSnippets.start_lsp_server({ match = false })

local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git({ index = false }),
    view = {
        style = 'sign',
        signs = { add = '+', change = '~', delete = '-' },
    },
})


require("tree-sitter-manager").setup()

require("mini.visits").setup()

local make_pick_visits = function(select_global, recency_weight)
    local extra = require('mini.extra')
    return function()
        local cwd = select_global and '' or vim.fn.getcwd()
        extra.pickers.visit_paths({ cwd = cwd, recency_weight = recency_weight })
    end
end

local map = function(lhs, desc, ...)
    vim.keymap.set('n', lhs, make_pick_visits(...), { desc = desc })
end

map('<Leader>vy', 'Pick frecent (all)', true, 0.5)
map('<Leader>vY', 'Pick frecent (cwd)', false, 0.5)

require('mini.hipatterns').setup({
    highlighters = {
        fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
        hack  = { pattern = 'HACK', group = 'MiniHipatternsHack' },
        todo  = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
        note  = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
    }
})

require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
local MiniBracketed = require('mini.bracketed')
MiniBracketed.setup({
    buffer = { suffix = '' },
})

vim.keymap.set('n', '<S-h>', function() MiniBracketed.buffer('backward') end, { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-l>', function() MiniBracketed.buffer('forward') end, { desc = 'Next buffer' })

local MiniBufremove = require("mini.bufremove")
MiniBufremove.setup()

vim.keymap.set('n', '<leader>bd', function() MiniBufremove.delete(0, false) end, { desc = 'Delete buffer' })
