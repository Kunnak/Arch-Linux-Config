-- LuaSnip Konfiguration
local ls = require("luasnip")

-- Windows-Pfad korrigieren
local snippets_path = vim.fn.stdpath("config") .. "/snippets/"

-- Lade alle Snippet-Types
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

-- UI5-spezifische Snippets laden
require("luasnip.loaders.from_lua").load({paths = snippets_path})

-- Debugging: Zeige geladene Snippets
vim.api.nvim_create_user_command("LuaSnipEdit", function()
    require("luasnip.loaders.from_lua").edit_snippet_files()
end, {})

-- Snippet Expansion Keybinds
vim.keymap.set({"i", "s"}, "<C-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true, desc = "LuaSnip: Expand or jump forward"})

vim.keymap.set({"i", "s"}, "<C-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true, desc = "LuaSnip: Jump backward"})

-- Tab für Snippet Expansion (falls kein completion menu offen)
vim.keymap.set("i", "<C-k>", function()
    if ls.expandable() then
        ls.expand()
    end
end, { silent = true, desc = "LuaSnip: Expand snippet" })

-- Auswahl in Choice Nodes
vim.keymap.set({"i", "s"}, "<C-e>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true, desc = "LuaSnip: Change choice" })

-- Reload snippets command
vim.api.nvim_create_user_command("LuaSnipReload", function()
    require("luasnip.loaders.from_lua").load({paths = snippets_path})
    print("LuaSnip snippets reloaded!")
end, { desc = "Reload LuaSnip snippets" })
