vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project view" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever : Paste yanked text without replacing the text in the buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Space paste" })

-- next greatest remap ever : Yanking to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line to clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to null register" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format according to Lsp" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Replace every word"})
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable"} )

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" });

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, {desc = "Source changes"})
