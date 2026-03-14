-- ==================================================================================
-- Neovim Grundeinstellungen
-- ==================================================================================
-- Globale Vim-Optionen und Konfiguration für alle Plugin-Manager
-- ==================================================================================

-- Leader Key (muss vor allen anderen Keybindings gesetzt werden)
vim.g.mapleader = " "

-- ==================================================================================
-- DISPLAY & THEME
-- ==================================================================================

vim.o.background = "dark"                -- Dunkler Modus für bessere Theme-Kompatibilität
vim.opt.termguicolors = true             -- 24-bit Farben aktivieren
vim.opt.guifont = "UbuntuMono Nerd Font:h24"  -- Font für GUI-Versionen
vim.opt.cursorline = true                -- Cursor-Linie aktiviert

-- ==================================================================================
-- ZEILENNUMMERN & NAVIGATION
-- ==================================================================================

vim.opt.number = true                    -- Absolute Zeilennummern
vim.opt.relativenumber = true            -- Relative Zeilennummern für Navigation
vim.opt.signcolumn = "yes"               -- Git/LSP Signs immer anzeigen
vim.opt.scrolloff = 8                    -- 8 Zeilen Puffer beim Scrollen

-- ==================================================================================
-- TEXT BEARBEITUNG
-- ==================================================================================

-- Einrückung (4 Spaces, einheitlich für alle Sprachen)
vim.opt.tabstop = 4                      -- Tab-Breite: 4 Zeichen
vim.opt.shiftwidth = 4                   -- Einrückung: 4 Zeichen
vim.opt.expandtab = true                 -- Tabs zu Leerzeichen konvertieren
vim.opt.smartindent = true               -- Intelligente Einrückung

-- Zeilenumbruch & Textbreite
vim.opt.linebreak = true                 -- Wörter nicht abschneiden
vim.opt.wrap = false                     -- Keine automatischen Zeilenumbrüche
vim.opt.textwidth = 120                  -- Textbreite für Formatter

-- ==================================================================================
-- SUCHE
-- ==================================================================================

vim.opt.hlsearch = true                  -- Such-Highlights aktivieren
vim.opt.incsearch = true                 -- Inkrementelle Suche (während Tippen)
vim.opt.ignorecase = true                -- Groß-/Kleinschreibung ignorieren
vim.opt.smartcase = true                 -- Außer bei Großbuchstaben in Suche

-- ==================================================================================
-- SYSTEM INTEGRATION
-- ==================================================================================

vim.opt.clipboard = "unnamedplus"        -- System-Clipboard nutzen
vim.opt.undofile = true                  -- Persistente Undo-Historie
vim.opt.timeoutlen = 200                 -- Kurze Timeout für Key-Kombinationen

-- ==================================================================================
-- SYNTAX & HIGHLIGHTING
-- ==================================================================================

vim.cmd("syntax on")                     -- Syntax-Highlighting aktivieren
