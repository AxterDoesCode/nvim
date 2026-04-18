vim.filetype.add({
    extension = {
        bsv = "bsv"
    }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

vim.lsp.config("blues_lsp", {
    cmd = { "blues", "lsp" },
    filetypes = { "bsv" },
    root_markers = { "blues.toml", "blues_compdb.json", ".git" },
    capabilities = capabilities,
})
vim.lsp.enable("blues_lsp")
