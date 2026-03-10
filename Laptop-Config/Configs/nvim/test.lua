-- Math Bibliothek testen
local function mathTest()
    local x = 16
    local wurzel = math.sqrt(x)                     -- math. sollte Vorschläge zeigen
    local power = 2 ^ 8                             -- math.pow
    local random = math.random(1, 100)              -- math.random
    local floor = math.floor(3.7)                   -- math.floor
    local ceil = math.ceil(3.2)                     -- math.ceil
    local pi = math.pi                              -- math.pi Konstante

    return wurzel, power, random
end

-- String Bibliothek testen
local function stringTest()
    local text = "Hallo Welt"
    local upper = string.upper(text)                -- string.upper
    local lower = string.lower(text)                -- string.lower
    local len = string.len(text)                    -- string.len
    local sub = string.sub(text, 1, 5)              -- string.sub
    local find = string.find(text, "Welt")          -- string.find
    local replace = text:gsub("Welt", "Lua")        -- gsub mit Methodensyntax

    return upper, len
end

-- Table Bibliothek testen
local function tableTest()
    local t = {1, 2, 3, 4, 5}
    table.insert(t, 6)                              -- table.insert
    table.remove(t, 1)                              -- table.remove
    table.sort(t)                                   -- table.sort

    local t2 = {a = 1, b = 2, c = 3}
    local keys = {}
    for k, v in pairs(t2) do                        -- pairs()
        table.insert(keys, k)
    end

    return t, keys
end

local function pow(a, b)
   return a ^ b
end
