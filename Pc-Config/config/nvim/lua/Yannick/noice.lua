-- Notify und Noice Konfiguration
vim.cmd([[highlight NotifyBackground guibg=#000000]])

require("notify").setup({
    background_colour = "#000000",
    top_down = false,
    stages = "fade_in_slide_out",
    render = "wrapped-compact",
    timeout = 5000,
    max_width = function()
        return math.floor(vim.o.columns * 0.9)
    end,
    max_height = 10,
    minimum_width = 50,
    fps = 30,
    icons = {
        ERROR = "✖ ",
        WARN = "⚠ ",
        INFO = "ℹ ",
        DEBUG = " ",
        TRACE = "✎ ",
    },
    level = vim.log.levels.WARN,
})

vim.notify = require("notify")

require("noice").setup({
    presets = { 
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
    },
    cmdline = {
        view = "cmdline_popup",
        format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = "🔍", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "🔍", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "💡" },
        },
    },
    messages = {
        view = "notify",
    },
    notify = {
        enabled = true,
        view = "notify",
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
})