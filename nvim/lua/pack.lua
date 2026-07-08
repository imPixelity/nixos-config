vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/RRethy/base16-nvim" },
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

local MiniFiles = require("mini.files")
MiniFiles.setup({
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
vim.keymap.set("n", "<leader>E", function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end,
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

require("mini.surround").setup()

local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>pf", function() MiniPick.builtin.files() end, { desc = "Mini file picker" })
vim.keymap.set("n", "<leader>ps", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Mini grep" })
vim.keymap.set("n", "<leader>vh", function() MiniPick.builtin.help() end, { desc = "Mini help" })

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini picker diagnostic" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = "Search keymaps" })

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
})

require("tree-sitter-manager").setup()
