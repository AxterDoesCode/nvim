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

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "LSP: go to implementation")
        map("n", "gr", vim.lsp.buf.references, "LSP: references")
        map("n", "K", vim.lsp.buf.hover, "LSP: hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
        map("n", "<leader>ds", function()
            require("telescope.builtin").lsp_document_symbols()
        end, "LSP: document symbols")
        map("n", "<leader>ws", function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end, "LSP: workspace symbols")
        map("n", "<leader>e", vim.diagnostic.open_float, "Diagnostics: float")

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/foldingRange") then
            vim.wo[0][0].foldmethod = "expr"
            vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
            vim.wo[0][0].foldlevel = 99
        end
    end,
})

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

-- Navigate out of terminal mode
vim.keymap.set("t", "<C-w>h", function() vim.cmd("stopinsert") vim.cmd("wincmd h") end, { desc = "Terminal: go left" })
vim.keymap.set("t", "<C-w>j", function() vim.cmd("stopinsert") vim.cmd("wincmd j") end, { desc = "Terminal: go down" })
vim.keymap.set("t", "<C-w>k", function() vim.cmd("stopinsert") vim.cmd("wincmd k") end, { desc = "Terminal: go up" })
vim.keymap.set("t", "<C-w>l", function() vim.cmd("stopinsert") vim.cmd("wincmd l") end, { desc = "Terminal: go right" })
vim.keymap.set("t", "<C-w>w", function() vim.cmd("stopinsert") vim.cmd("wincmd w") end, { desc = "Terminal: go to next window" })
