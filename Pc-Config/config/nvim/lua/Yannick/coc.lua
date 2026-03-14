-- ==================================================================================
-- CoC (Conquer of Completion) Konfiguration - Windows-optimiert
-- ==================================================================================

-- CoC Windows-Kompatibilität konfigurieren
vim.g.coc_disable_startup_warning = 1
vim.g.coc_disable_transparent_cursor = 1

-- Node.js Pfad explizit setzen (wichtig für Windows)
if vim.fn.executable('node') == 1 then
    vim.g.coc_node_path = vim.fn.exepath('node')
end

-- CoC Extensions (alle deine benötigten LSPs)
vim.g.coc_global_extensions = {
    -- Web Development
    'coc-tsserver',                      -- TypeScript/JavaScript ✅
    'coc-html',                          -- HTML ✅
    'coc-css',                           -- CSS
    'coc-json',                          -- JSON ✅
    'coc-yaml',                          -- YAML ✅
    'coc-xml',                           -- XML ✅

    -- Programming Languages
    'coc-java',                          -- Java ✅
    'coc-lua',                           -- Lua ✅
    'coc-pyright',                       -- Python (optional)

    -- Utilities
    'coc-snippets',                      -- Code Snippets
    'coc-pairs',                         -- Auto-Pairing
    'coc-eslint',                        -- ESLint für JavaScript

    -- SAP UI5 Support (über TypeScript/JavaScript)
    -- SAP UI5 wird über coc-tsserver unterstützt
}

-- CoC UI Styling
vim.g.coc_borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'}

-- LSP-ähnliche Keybindings
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true, desc = "Go to Definition"})
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true, desc = "Go to Type Definition"})
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true, desc = "Go to Implementation"})
vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true, desc = "Show References"})
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true, desc = "Rename Symbol"})
vim.keymap.set("n", "<leader>ca", "<Plug>(coc-codeaction)", {silent = true, desc = "Code Actions"})
vim.keymap.set("n", "<leader>k", "<Plug>(coc-documentation)", {silent = true, desc = "Show Documentation"})

-- Formatierung (manuell, da Auto-Format deaktiviert ist)
vim.keymap.set("n", "<leader>cf", "<Plug>(coc-format)", {silent = true, desc = "Format Code (manuell)"})
vim.keymap.set("v", "<leader>cf", "<Plug>(coc-format-selected)", {silent = true, desc = "Format Selection"})
vim.keymap.set("n", "<leader>cF", function()
    vim.cmd("normal! gg=G")  -- Vim native formatting als Alternative
end, {silent = true, desc = "Format Code (Vim native)"})

-- Hover Documentation (wie VSCode)
local function show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
vim.keymap.set("n", "K", show_docs, {silent = true, desc = "Show Documentation"})

-- Tab-Completion (VSCode-ähnlich)
local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.keymap.set("i", "<ENTER>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<ENTER>"]], opts)

-- Global function für Tab-Completion
_G.check_back_space = check_back_space

-- CoC Styling (grauer Hintergrund für Completion Menu)
vim.cmd([[
    highlight Pmenu guibg=#3a3a3a guifg=#ffffff
    highlight PmenuSel guibg=#5a5a5a guifg=#ffffff
    highlight PmenuSbar guibg=#2a2a2a
    highlight PmenuThumb guibg=#6a6a6a
    highlight CocFloating guibg=#3a3a3a guifg=#ffffff
    highlight CocMenuSel guibg=#5a5a5a guifg=#ffffff
    
    " CoC Documentation Styling
    highlight CocHoverRange guibg=#4a4a4a guifg=#ffffff
    highlight CocErrorFloat guibg=#3a3a3a guifg=#ff6b6b
    highlight CocWarningFloat guibg=#3a3a3a guifg=#ffd700
    highlight CocInfoFloat guibg=#3a3a3a guifg=#87ceeb
    highlight CocHintFloat guibg=#3a3a3a guifg=#98fb98
]])

-- Inline Diagnostics Configuration - Virtueller Text IMMER anzeigen
vim.diagnostic.config({
    virtual_text = {
        enabled = true,                  -- Virtuelle Texte IMMER aktivieren
        prefix = "●",                    -- Symbol vor der Nachricht
        spacing = 2,                     -- Abstand zwischen Code und virtueller Text
        severity_sort = true,            -- Nach Schweregrad sortieren
        source = "if_many",              -- Quelle nur anzeigen wenn mehrere vorhanden
        format = function(diagnostic)
            -- Format: [ERROR] Nachricht
            local severity_map = {
                [vim.diagnostic.severity.ERROR] = "ERROR",
                [vim.diagnostic.severity.WARN] = "WARN", 
                [vim.diagnostic.severity.INFO] = "INFO",
                [vim.diagnostic.severity.HINT] = "HINT",
            }
            local severity = severity_map[diagnostic.severity] or "UNKNOWN"
            return string.format("[%s] %s", severity, diagnostic.message)
        end,
    },
    underline = true,                    -- Fehler unterstreichen
    update_in_insert = false,            -- Nicht während Tippen aktualisieren
    severity_sort = true,                -- Nach Schweregrad sortieren
    signs = {
        enabled = true,                  -- Zeichen in der Sign-Column
        priority = 20,                   -- Priorität der Signs
    },
    float = {
        enabled = false,                 -- KEIN automatisches Hover-Fenster
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'if_many',
        prefix = '',
        scope = 'cursor',
        header = "",
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
})

-- Keybinding für Diagnostic Navigation
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show Diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })

-- ==================================================================================
-- LSP-ähnliche User Commands für CoC (damit :LspInfo etc. funktioniert)
-- ==================================================================================

-- :LspInfo -> :CocInfo
vim.api.nvim_create_user_command('LspInfo', function()
    vim.cmd('CocInfo')
end, { desc = 'Show CoC LSP Information' })

-- :LspRestart -> :CocRestart  
vim.api.nvim_create_user_command('LspRestart', function()
    vim.cmd('CocRestart')
end, { desc = 'Restart CoC LSP' })

-- :LspStart -> CoC Services aktivieren
vim.api.nvim_create_user_command('LspStart', function()
    vim.cmd('CocStart')
end, { desc = 'Start CoC LSP' })

-- :LspStop -> CoC Services deaktivieren  
vim.api.nvim_create_user_command('LspStop', function()
    vim.cmd('CocDisable')
end, { desc = 'Stop CoC LSP' })

-- :LspLog -> CoC Logs anzeigen
vim.api.nvim_create_user_command('LspLog', function()
    vim.cmd('CocCommand workspace.showOutput')
end, { desc = 'Show CoC LSP Logs' })

-- Zusätzliche nützliche CoC-Befehle als Aliases
vim.api.nvim_create_user_command('LspDiagnostics', function()
    vim.cmd('CocList diagnostics')
end, { desc = 'Show LSP Diagnostics' })

vim.api.nvim_create_user_command('LspCommands', function()
    vim.cmd('CocList commands')
end, { desc = 'Show Available LSP Commands' })

vim.api.nvim_create_user_command('LspExtensions', function()
    vim.cmd('CocList extensions')
end, { desc = 'Show LSP Extensions' })

-- ==================================================================================
-- CoC Gruvbox Highlights - Optimierte spaltenbasierte Darstellung
-- ==================================================================================

-- Gruvbox Farben
local gruvbox = {
    bg0 = "#282828",
    bg1 = "#3c3836", 
    bg2 = "#504945",
    bg3 = "#665c54",
    fg0 = "#fbf1c7",
    fg1 = "#ebdbb2",
    fg4 = "#a89984",
    orange = "#fe8019",
    yellow = "#fabd2f",
    green = "#b8bb26",
    aqua = "#8ec07c",
    blue = "#83a598",
    purple = "#d3869b",
    red = "#fb4934",
}

-- CoC Floating Window (Hauptmenü)
vim.api.nvim_set_hl(0, "CocFloating", { bg = gruvbox.bg1, fg = gruvbox.fg1 })
vim.api.nvim_set_hl(0, "CocFloatingBorder", { bg = gruvbox.bg1, fg = gruvbox.bg3 })

-- CoC Completion Menu
vim.api.nvim_set_hl(0, "CocPumMenu", { bg = gruvbox.bg1, fg = gruvbox.fg1 })
vim.api.nvim_set_hl(0, "CocPumSearch", { bg = gruvbox.bg2, fg = gruvbox.blue, bold = true })  -- Inc-search blau
vim.api.nvim_set_hl(0, "CocPumDetail", { bg = gruvbox.bg1, fg = gruvbox.fg4 })

-- Selected Item (aktuelle Auswahl)
vim.api.nvim_set_hl(0, "CocMenuSel", { bg = gruvbox.bg2, fg = gruvbox.fg0, bold = true })

-- Spalten-spezifische Highlights
-- Spalte 1: Vorschlag (Label)
vim.api.nvim_set_hl(0, "CocPumVirtualText", { fg = gruvbox.fg1 })

-- Spalte 2: Icons (Kind) - verschiedene Farben für verschiedene Typen
vim.api.nvim_set_hl(0, "CocSymbolFunction", { fg = gruvbox.blue })     -- Funktionen blau
vim.api.nvim_set_hl(0, "CocSymbolMethod", { fg = gruvbox.blue })       -- Methoden blau
vim.api.nvim_set_hl(0, "CocSymbolVariable", { fg = gruvbox.aqua })     -- Variablen aqua
vim.api.nvim_set_hl(0, "CocSymbolField", { fg = gruvbox.green })       -- Fields grün
vim.api.nvim_set_hl(0, "CocSymbolProperty", { fg = gruvbox.green })    -- Properties grün
vim.api.nvim_set_hl(0, "CocSymbolClass", { fg = gruvbox.yellow })      -- Klassen gelb
vim.api.nvim_set_hl(0, "CocSymbolInterface", { fg = gruvbox.yellow })  -- Interfaces gelb
vim.api.nvim_set_hl(0, "CocSymbolEnum", { fg = gruvbox.yellow })       -- Enums gelb
vim.api.nvim_set_hl(0, "CocSymbolKeyword", { fg = gruvbox.red })       -- Keywords rot
vim.api.nvim_set_hl(0, "CocSymbolSnippet", { fg = gruvbox.purple })    -- Snippets lila
vim.api.nvim_set_hl(0, "CocSymbolConstant", { fg = gruvbox.orange })   -- Konstanten orange
vim.api.nvim_set_hl(0, "CocSymbolOperator", { fg = gruvbox.fg1 })      -- Operatoren normal

-- Spalte 3: Herkunft (Menu) - verschiedene Farben für verschiedene Quellen
vim.api.nvim_set_hl(0, "CocPumMenuLSP", { fg = gruvbox.green })        -- LSP grün
vim.api.nvim_set_hl(0, "CocPumMenuSnippets", { fg = gruvbox.purple })  -- Snippets lila
vim.api.nvim_set_hl(0, "CocPumMenuBuffer", { fg = gruvbox.aqua })      -- Buffer aqua
vim.api.nvim_set_hl(0, "CocPumMenuFile", { fg = gruvbox.yellow })      -- File gelb
vim.api.nvim_set_hl(0, "CocPumMenuPath", { fg = gruvbox.blue })        -- Path blau

-- Scrollbar
vim.api.nvim_set_hl(0, "CocPumThumb", { bg = gruvbox.bg3 })
vim.api.nvim_set_hl(0, "CocPumSbar", { bg = gruvbox.bg2 })
