require("mini.ai").setup()
require("mini.align").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.completion").setup()
require("mini.indentscope").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

require("mini.cmdline").setup({
    autocorrect = { enable = false },
})

require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

require("mini.hipatterns").setup({
    highlighters = {
        fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
        hack  = { pattern = "HACK", group = "MiniHipatternsHack" },
        todo  = { pattern = "TODO", group = "MiniHipatternsTodo" },
        note  = { pattern = "NOTE", group = "MiniHipatternsNote" },
    }
})

require("mini.visits").setup()
local make_pick_visits = function(select_global, recency_weight)
    local extra = require("mini.extra")
    return function()
        local cwd = select_global and '' or vim.fn.getcwd()
        extra.pickers.visit_paths({ cwd = cwd, recency_weight = recency_weight })
    end
end
local map = function(lhs, desc, ...) vim.keymap.set("n", lhs, make_pick_visits(...), { desc = desc }) end
map("<Leader>sv", "Pick frecent (all)", true, 0.5)
map("<Leader>sV", "Pick frecent (cwd)", false, 0.5)

local MiniBufremove = require("mini.bufremove")
MiniBufremove.setup()
vim.keymap.set("n", "<leader>bd", function() MiniBufremove.delete() end, { desc = "Delete buffer" })

local MiniBracketed = require("mini.bracketed")
MiniBracketed.setup({ buffer = { suffix = "" } })
vim.keymap.set("n", "<S-h>", function() MiniBracketed.buffer("backward") end, { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", function() MiniBracketed.buffer("forward") end, { desc = "Next buffer" })

local MiniFiles = require("mini.files")
MiniFiles.setup({ mappings = { close = "<C-c>", go_in = "<CR>", go_in_plus = "L", go_out = "_", go_out_plus = "H" } })
vim.keymap.set("n", "<leader>e", function() MiniFiles.open() end, { desc = "Open mini file explorer" })
vim.keymap.set("n", "<leader>-", function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end, { desc = "Open mini file explorer to current opened file" })

local MiniPick = require("mini.pick")
MiniPick.setup()
vim.keymap.set("n", "<leader>sf", function() MiniPick.builtin.files() end, { desc = "Mini file picker" })
vim.keymap.set("n", "<leader>sg", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Mini grep" })
vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.help() end, { desc = "Mini help" })
vim.keymap.set("n", "<leader>sb", function() MiniPick.builtin.buffers() end, { desc = "Mini buffers" })

local MiniExtra = require("mini.extra")
MiniExtra.setup()
vim.keymap.set("n", "<leader>sd", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini picker diagnostic" })
vim.keymap.set("n", "<leader>sk", function() MiniExtra.pickers.keymaps() end, { desc = "Mini picker keymaps" })
vim.keymap.set("n", "<leader>sh", function() MiniExtra.pickers.git_hunks() end, { desc = "Mini picker git hunks" })

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({ snippets = { MiniSnippets.gen_loader.from_lang() } })
MiniSnippets.start_lsp_server({ match = false })

local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git({ index = false }),
    view = { style = "sign", signs = { add = "+", change = "~", delete = "-" } },
})
