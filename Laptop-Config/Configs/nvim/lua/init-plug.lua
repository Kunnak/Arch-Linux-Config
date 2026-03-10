-- ==================================================================================
-- Vim-Plug 
-- ==================================================================================

vim.g.mapleader = " "

-- ==================================================================================
-- Grundeinstellungen
-- ==================================================================================
require('Yannick.options')
require('Yannick.keymaps')

-- ==================================================================================
-- Plugin Installation
-- ==================================================================================
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- UI & Theme
Plug('ellisonleao/gruvbox.nvim')                                        -- Gruvbox Theme
Plug('nvim-lualine/lualine.nvim')                                       -- Statusleiste
Plug('nvim-tree/nvim-web-devicons')                                     -- Icons

-- Command-Palette & Benachrichtigungen
Plug('folke/noice.nvim')                                                -- Command-Palette
Plug('MunifTanjim/nui.nvim')                                            -- UI-Komponenten
Plug('rcarriga/nvim-notify')                                            -- Benachrichtigungen

-- Telescope (Fuzzy Finder)
Plug('nvim-lua/plenary.nvim')                                           -- Lua-Utilities
Plug('nvim-telescope/telescope.nvim', {branch = 'master'})              -- Fuzzy Finder (neueste Version)
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make'})     -- Performance

-- CoC (LSP & Code Completion)
Plug('neoclide/coc.nvim', {branch = 'release'})                         -- LSP & Completion

-- Git Integration
Plug('tpope/vim-fugitive')                                              -- Git-Befehle
Plug('airblade/vim-gitgutter')                                          -- Git-Änderungen

-- Editing Utilities
Plug('tpope/vim-commentary')                                            -- Kommentieren (gcc)
Plug('mg979/vim-visual-multi')                                          -- Multi-Cursor
Plug('windwp/nvim-autopairs')                                           -- Auto-Klammern
Plug('haya14busa/incsearch.vim')                                        -- Verbesserte Suche

-- Syntax Highlighting
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})         -- Moderne Syntax

vim.call('plug#end')

-- ==================================================================================
-- Plugin Konfiguration
-- ==================================================================================
vim.defer_fn(function()

    -- Netrw Styling
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "netrw",
        callback = function()
            vim.opt_local.cursorline = false
        end,
    })

    -- Theme & Farben
    pcall(function()
        require('Yannick.theme')
    end)

    -- Telescope (mit Styling)
    pcall(function()
        require('Yannick.telescope')

        -- Telescope UI-Styling
        vim.cmd([[
            highlight TelescopeNormal guibg=#2a2a2a
            highlight TelescopeBorder guibg=#2a2a2a guifg=#5a5a5a
            highlight TelescopePromptNormal guibg=#3a3a3a
            highlight TelescopePromptBorder guibg=#3a3a3a guifg=#6a6a6a
            highlight TelescopePromptTitle guibg=#ff8800 guifg=#000000
            highlight TelescopePreviewTitle guibg=#5a5a5a guifg=#ffffff
            highlight TelescopeResultsTitle guibg=#5a5a5a guifg=#ffffff
        ]])

        -- Telescope Keybindings nochmals setzen (Sicherheit)
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope: Find Files' })
        vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope: Live Grep' })
        vim.keymap.set('n', '<leader>F', builtin.buffers, { desc = 'Telescope: Buffers' })
        vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope: Help Tags' })
    end)

    -- Noice
    pcall(function()
        require('Yannick.noice')
    end)

    -- Lualine
    pcall(function()
        require('Yannick.lualine')
    end)

    -- Treesitter (mit Compatibility-Fix laden)
    pcall(function()
        require('Yannick.treesitter')
    end)

    -- Autopairs
    pcall(function()
        require('Yannick.autopairs')
    end)

    -- CoC
    local coc_success, coc_err = pcall(function()
        require('Yannick.coc')
    end)

    if not coc_success then
        print("CoC-Fehler: " .. tostring(coc_err))
        print("Versuche CoC-Installation zu überprüfen...")
    else
        print("CoC erfolgreich geladen!")
    end

end, 200)
