local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'rust_analyzer',
    -- 'gopls',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lspconfig = require("lspconfig")

lspconfig.gopls.setup {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_pattern = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}

lspconfig.clangd.setup {
    init_options = {
        fallbackFlags = {'--std=c++23'}
    },
    cmd = {
        "clangd",
        "--fallback-style=webkit"
    }
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});

lspconfig.arduino_language_server.setup {
    filetypes = {"arduino"},
    root_dir = lspconfig.util.root_pattern("*.ino"),
    cmd = {
        "arduino-language-server",
    },
    capabilities = {
        textDocument = {
            semanticTokens = vim.NIL,
        },
        workspace = {
            semanticTokens = vim.NIL,
        },
    },
}

-- lsp.configure('omnisharp', {
--   handlers = {
--     ["textDocument/definition"] = require('omnisharp_extended').handler,
--   }
-- })

-- lspconfig.omnisharp.setup {
--     cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
--     enable_import_completion = true,
--     organize_imports_on_format = true,
--     enable_roslyn_analyzers = true,
--     root_dir = vim.loop.cwd, -- current working directory
--     RoslynExtensionsOptions = {
--         -- Enables support for roslyn analyzers, code fixes and rulesets.
--         EnableAnalyzersSupport = nil,
--         -- Enables support for showing unimported types and unimported extension
--         -- methods in completion lists. When committed, the appropriate using
--         -- directive will be added at the top of the current file. This option can
--         -- have a negative impact on initial completion responsiveness,
--         -- particularly for the first few completion sessions after opening a
--         -- solution.
--         EnableImportCompletion = nil,
--         -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--         -- true
--         AnalyzeOpenDocumentsOnly = nil,
--         EnableDecompilationSupport = true,
--     },
-- }

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
