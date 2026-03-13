-- ======================================================
-- Neovim
-- ======================================================

-- ======================================================
-- Modis
-- ======================================================
-- "lazy"    = LazyVim Setup
-- "plug"    = vim-plug Setup

local config_mode = "plug"

-- ======================================================
-- VSCode
-- ======================================================
if vim.g.vscode then
    require('vscode-config')

-- ======================================================  
-- Lazyvim Setup
-- ======================================================
elseif config_mode == "lazy" then
    require('Yannick.options')
    require('Yannick.plugins')
    require('Yannick.keymaps')
    require('Yannick.theme')
    require('Yannick.blink')
    require('Yannick.lsp')
    require('Yannick.telescope')
    require('Yannick.noice')
    require('Yannick.lualine')
    require('Yannick.luasnip')
    require('Yannick.inline-diagnostic')

-- ======================================================
-- Vim-Plug Setup
-- ======================================================
elseif config_mode == "plug" then
    require('init-plug')
end
