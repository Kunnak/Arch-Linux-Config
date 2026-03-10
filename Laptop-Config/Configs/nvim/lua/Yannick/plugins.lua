local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Treesitter
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Theme
    { "ellisonleao/gruvbox.nvim",
        priority = 1000
    },

    -- Mason
    { "mason-org/mason.nvim",
        opts = {}
    },

    -- LSP-Config
    { "neovim/nvim-lspconfig" },

    -- Inline Diagnostic
    { "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
    },

    -- Blink.cmp
    { "saghen/blink.cmp",
        dependencies = { 
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip',
        },
        version = '1.*',
    },

    -- LuaSnip für erweiterte Snippets
    { 'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = function()
            if vim.fn.has("win32") == 1 then
                return "echo 'LuaSnip installed without jsregexp on Windows'"
            else
                return "make install_jsregexp"
            end
        end,
    },

    -- Telescope
    { 'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Noice.nvim
    { 'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            "rcarriga/nvim-notify"
        },
    },

    -- LuaLine
    { 'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    },
})
