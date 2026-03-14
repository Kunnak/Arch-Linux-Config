-- ==================================================================================
-- Treesitter Konfiguration
-- ==================================================================================

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "lua", 
        "javascript", 
        "typescript", 
        "python", 
        "rust", 
        "c", 
        "cpp", 
        "java",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "markdown"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}
