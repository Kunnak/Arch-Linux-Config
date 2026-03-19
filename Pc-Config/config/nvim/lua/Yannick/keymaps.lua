-- ==================================================================================
-- Keybindings - Zentrale Tastenkombinationen
-- ==================================================================================
-- Gemeinsame Keybindings für alle Plugin-Manager
-- Plugin-spezifische Keybindings werden in den jeweiligen Plugin-Konfigurationen definiert
-- ==================================================================================

-- ==================================================================================
-- DATEI-EXPLORER (Netrw)
-- ==================================================================================

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, {
    desc = "Netrw Explorer öffnen"
})
vim.keymap.set("n", "<leader>E", function()
    vim.cmd('tabnew')
    vim.cmd.Ex()
end, {
    desc = "Netrw in neuem Tab"
})

-- ==================================================================================
-- NAVIGATION
-- ==================================================================================
vim.keymap.set("n", "<C-j>", "<C-d>zz", {
    desc = "Halbe Seite nach unten scrollen (zentriert)"
})
vim.keymap.set("n", "<C-k>", "<C-u>zz", {
    desc = "Halbe Seite nach oben scrollen (zentriert)"
})

-- ==================================================================================
-- TAB-NAVIGATION
-- ==================================================================================

vim.keymap.set("n", "<leader>t", 'gt', {
    desc = "Nächster Tab"
})
vim.keymap.set("n", "<leader>q", 'gT', {
    desc = "Vorheriger Tab"
})
vim.keymap.set("n", "<leader>T", ":tabnew<CR>", {
    desc = "Neuer Tab"
})
vim.keymap.set("n", "j", function()
    return vim.v.count > 0 and "j" or "gj"
end, { expr = true, desc = "Down-Movement für Wrapping" })

vim.keymap.set("n", "k", function()
    return vim.v.count > 0 and "k" or "gk"
end, { expr = true, desc = "Up-Movement für Wrapping" })

vim.keymap.set({"x", "o"}, "ii", "ip", { remap = true, desc = "Inner paragraph (alias for ip)" })

-- ==================================================================================
-- UTILITIES
-- ==================================================================================

vim.keymap.set("n", "<leader><Esc>", ":nohlsearch<CR>", {
    desc = "Such-Highlights löschen"
})

-- ==================================================================================
-- VERZEICHNIS-MANAGEMENT
-- ==================================================================================

-- Verzeichnis zum aktuellen Dateipfad wechseln und Explorer öffnen
local function change_to_current_dir()
    local current_file = vim.fn.expand('%:p:h')
    if current_file ~= '' then
        vim.cmd('cd ' .. current_file)
        print('Arbeitsverzeichnis: ' .. current_file)
        vim.cmd('Ex')
    else
        local cwd = vim.fn.getcwd()
        print('Arbeitsverzeichnis: ' .. cwd)
        vim.cmd('Ex')
    end
end

vim.keymap.set('n', '<leader>m', change_to_current_dir, {
    desc = 'Zum Datei-Verzeichnis wechseln'
})

-- ==================================================================================
-- TELESCOPE KEYBINDINGS (nur wenn verfügbar)
-- ==================================================================================

-- Sichere Telescope-Keybindings mit Fallback
local function setup_telescope_keymaps()
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then
        vim.keymap.set('n', '<leader>f', builtin.find_files, {
            desc = 'Telescope: Find Files'
        })
        vim.keymap.set('n', '<leader>g', builtin.live_grep, {
            desc = 'Telescope: Live Grep'
        })
        vim.keymap.set('n', '<leader>F', builtin.buffers, {
            desc = 'Telescope: Buffers'
        })
        vim.keymap.set('n', '<leader>h', builtin.help_tags, {
            desc = 'Telescope: Help Tags'
        })
    else
        -- Fallback wenn Telescope nicht verfügbar
        vim.keymap.set('n', '<leader>f', ':find ', {
            desc = 'Find Files (native)'
        })
        vim.keymap.set('n', '<leader>F', ':buffers<CR>', {
            desc = 'Show Buffers'
        })
    end
end

-- Telescope Keymaps laden (mit Fehlerbehandlung)
setup_telescope_keymaps()
