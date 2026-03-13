-- ==================================================================================
-- nvim-autopairs Konfiguration
-- ==================================================================================

require("nvim-autopairs").setup({
    check_ts = true,                        -- Treesitter integration
    ts_config = {
        lua = {'string'},                   -- Don't add pairs in lua string treesitter nodes
        javascript = {'template_string'},   -- Don't add pairs in javascript template_string
        java = false,                       -- Don't check treesitter on java
    }
})
