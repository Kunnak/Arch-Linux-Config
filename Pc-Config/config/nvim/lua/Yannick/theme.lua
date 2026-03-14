vim.cmd([[colorscheme gruvbox]])

-- Gruvbox Farben für Completion Menüs
local gruvbox_colors = {
    bg0 = "#282828",
    bg1 = "#3c3836",
    bg2 = "#504945",
    bg3 = "#665c54",
    bg4 = "#7c6f64",
    fg0 = "#fbf1c7",
    fg1 = "#ebdbb2",
    fg2 = "#d5c4a1",
    fg3 = "#bdae93",
    fg4 = "#a89984",
    gray = "#928374",
    orange = "#fe8019",
    yellow = "#fabd2f",
    green = "#b8bb26",
    aqua = "#8ec07c",
    blue = "#83a598",
    purple = "#d3869b",
    red = "#fb4934",
}

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.opt_local.cursorline = false

-- Normale Zeilennummern auf hellgrau
vim.api.nvim_set_hl(0, "LineNr", { fg = "#aaaaaa" })

-- Aktuelle Zeilennummer auf orange und fett
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fe8019", bold = true })

-- Farbe der Strings
vim.api.nvim_set_hl(0, "String", { fg = gruvbox_colors.green })

-- Kommentare: ausgegraut (gruvbox gray) und NICHT kursiv
vim.api.nvim_set_hl(0, "Comment", { fg = gruvbox_colors.gray, italic = false })

-- Treesitter-Kommentare ebenfalls ausgegraut ohne kursiv (falls aktiviert)
vim.api.nvim_set_hl(0, "@comment", { fg = gruvbox_colors.gray, italic = false })

-- Quick Help (<F1>) in Gruvbox Orange
vim.api.nvim_set_hl(0, "QuickHelp", { fg = gruvbox_colors.green, bold = true })
vim.api.nvim_set_hl(0, "HelpKey", { fg = gruvbox_colors.green , bold = true })
vim.api.nvim_set_hl(0, "HelpCommand", { fg = gruvbox_colors.green  })
vim.api.nvim_set_hl(0, "helpHeader", { fg = gruvbox_colors.green , bold = true })
vim.api.nvim_set_hl(0, "helpSectionDelim", { fg = gruvbox_colors.green  })

-- Netrw Ordner-Farben in Gruvbox Orange
vim.api.nvim_set_hl(0, "netrwDir", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "netrwClassify", { fg = gruvbox_colors.green })
vim.api.nvim_set_hl(0, "netrwTreeBar", { fg = gruvbox_colors.green })
vim.api.nvim_set_hl(0, "netrwQuickHelp", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "netrwHelpCmd", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "netrwCmdSep", { fg = gruvbox_colors.green })
vim.api.nvim_set_hl(0, "netrwComment", { fg = gruvbox_colors.green })
vim.api.nvim_set_hl(0, "netrwList", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "netrwVersion", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "netrwBanner", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "netrwPlain", { fg = gruvbox_colors.fg0 })

vim.api.nvim_set_hl(0, "netrwHdr", { fg = gruvbox_colors.red, bold = true })
vim.api.nvim_set_hl(0, "netrwCwd", { fg = gruvbox_colors.red, bold = true })

-- Blink.cmp Highlights mit Gruvbox-Farben
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.bg3 })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = gruvbox_colors.bg2, fg = gruvbox_colors.fg0, bold = true })

-- Documentation Window
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = gruvbox_colors.bg0, fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = gruvbox_colors.bg0, fg = gruvbox_colors.bg3 })
vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { bg = gruvbox_colors.bg1 })

-- Kind Icons für verschiedene Completion-Typen
vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = gruvbox_colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = gruvbox_colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = gruvbox_colors.green })
vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = gruvbox_colors.aqua })
vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = gruvbox_colors.green })
vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = gruvbox_colors.purple })
vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = gruvbox_colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = gruvbox_colors.purple })
vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = gruvbox_colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = gruvbox_colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = gruvbox_colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = gruvbox_colors.aqua })
vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = gruvbox_colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = gruvbox_colors.aqua })

-- Telescope mit Gruvbox
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.bg3 })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = gruvbox_colors.bg2, fg = gruvbox_colors.fg0, bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = gruvbox_colors.orange })
vim.api.nvim_set_hl(0, "TelescopeMultiSelection", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = gruvbox_colors.blue, bold = true })

-- LSP-bezogene Highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = gruvbox_colors.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = gruvbox_colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = gruvbox_colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = gruvbox_colors.aqua })

-- LSP Signature Help (Parameter Hints)
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = gruvbox_colors.orange, bold = true })

-- Floating Windows (Hover, Signature Help, etc.)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.bg3 })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.orange, bold = true })

-- LSP Hover Window
vim.api.nvim_set_hl(0, "LspInfoBorder", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.bg3 })

-- Pmenu (fallback für manche LSP Windows)
vim.api.nvim_set_hl(0, "Pmenu", { bg = gruvbox_colors.bg1, fg = gruvbox_colors.fg1 })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = gruvbox_colors.bg2, fg = gruvbox_colors.fg0, bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = gruvbox_colors.bg2 })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = gruvbox_colors.bg4 })
