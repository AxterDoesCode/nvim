local options = {
    ensure_installed = {"go","javascript", "typescript", "c", "lua", "rust" },
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
    },
    sync_install = false,
    auto_install = true,
    

  indent = { enable = true },
}

return options
