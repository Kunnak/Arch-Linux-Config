-- Blink.cmp Konfiguration
require('blink.cmp').setup({
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
        },
    },
    completion = {
        accept = {
            auto_brackets = { enabled = true },
        },
        keyword = {
            range = 'full',
        },
        trigger = {
            prefetch_on_insert = false,
            show_on_insert_on_trigger_character = true,
        },
        menu = {
            enabled = true,
            min_width = 30,
            max_height = 10,
            border = 'single',
            winblend = 0,
            winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
            draw = {
                treesitter = { "lsp" },
                columns = { 
                    { "label", gap = 8 }, 
                    { "kind_icon", gap = 3 }, 
                    { "source_name", gap = 1 } 
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            treesitter_highlighting = true,
            window = {
                min_width = 15,
                max_height = 25,
                border = 'single',
                winblend = 0,
                winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
            },
        },
    },
    sources = {
        default = { "lsp", "buffer", "path", "snippets" },
        providers = {
            lsp = {
                name = "LSP",
                module = "blink.cmp.sources.lsp",
                score_offset = 1000,
                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        if item.source and item.source == "ui5_language_server" then
                            item.score_offset = 1500
                        end
                    end
                    return items
                end,
            },
            buffer = {
                name = "Buffer",
                module = "blink.cmp.sources.buffer",
                score_offset = 800,
            },
            path = {
                name = "Path",
                module = "blink.cmp.sources.path",
                score_offset = 200,
            },
            snippets = {
                name = "Snippets",
                module = "blink.cmp.sources.snippets",
                score_offset = 500,
                opts = {
                    friendly_snippets = true,
                    search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                    global_snippets = { "all" },
                    extended_filetypes = {
                        xml = { "xml", "html" },
                    },
                    ignored_filetypes = {},
                },
            },
        }
    },
    keymap = {
        preset = "enter",
        ['<C-c>'] = { 'show', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    fuzzy = {
        -- Einfache, stabile Fuzzy-Konfiguration
        use_frecency = false,
        use_proximity = false,
        max_items = 50,
    },
})
