require('telescope').setup{
    defaults = {
        -- UI Styling
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        results_title = false,
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        -- Ignored Files/Directories
        file_ignore_patterns = {
            "^%.",           -- Ignoriert alle versteckten Dateien/Ordner im Root (z.B. .vscode, .git)
            "/%.",           -- Ignoriert alle versteckten Dateien/Ordner in Unterverzeichnissen
            "node_modules/",    -- Ignoriert alles im node_modules-Ordner
            "node_modules/.*",  -- Ignoriert alles im node_modules-Ordner
            "node_modules/*",   -- Ignoriert alles im node_modules-Ordner
            "%.git/",           -- Ignoriert alles im .git-Ordner
            "%.lock",           -- Ignoriert alle .lock-Dateien
            "%.png",            -- Ignoriert alle PNG-Bilder
            "%.jpg",            -- Ignoriert alle JPG-Bilder
            "%.ogg",            -- Ignoriert alle OGG-Dateien
            "build/",           -- Ignoriert Build-Ordner
            "%.cache/*",        -- Ignoriert Build-Ordner
            "%.cargo/*",        -- Ignoriert Build-Ordner
            "%.DS_Store",       -- Ignoriert Mac-OS-Metadaten
        },

        find_command = {
            "fd",
            "--type", "f",
            "--hidden",
            "--exclude", ".git",
            "--strip-cwd-prefix",
            "--no-ignore-vcs",
            ".*" }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

-- FZF Extension laden
pcall(require('telescope').load_extension, 'fzf')
