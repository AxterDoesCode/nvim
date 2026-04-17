local M = {}

function M.setup()
  -- Register custom parsers inside a `User TSUpdate` autocmd — this is how
  -- nvim-treesitter (main branch) picks up non-builtin parser definitions
  -- before installing/updating them.
  vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
      require("nvim-treesitter.parsers").bsv = {
        install_info = {
          url = "https://github.com/AxterDoesCode/tree-sitter-bsv",
          branch = "main",
          queries = "queries",
        },
      }
    end,
  })

  -- Install parsers if missing. `install` is idempotent and async.
  require("nvim-treesitter").install({ "bsv" })

  -- Start treesitter highlighting when a BSV file is opened.
  -- `install` is async — on the very first launch the parser may not be
  -- ready yet when the autocmd fires, so swallow the error.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "bsv" },
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })
end

return M
