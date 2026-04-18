require("axtr.remaps")
require("axtr.set")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.hl = vim.highlight


local lazy_settings = {
  defaults = { lazy = true },
  install = { colorscheme = { "catppuccin-mocha" } },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
}
require("lazy").setup("plugins", lazy_settings)

-- filetypes.lua needs cmp_nvim_lsp on the rtp to build capabilities, so
-- it must run after lazy has loaded the completion deps.
require("axtr.filetypes")
