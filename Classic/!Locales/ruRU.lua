-- Dire Maul

local L = BigWigs:NewBossLocale("Lethtendris", "ruRU")
if not L then return end
if L then
	L.pimgib = "Пимгиб"
end

-- Stratholme

L = BigWigs:NewBossLocale("Lord Aurius Rivendare", "ruRU")
if L then
	L.death_pact_trigger = "пытается применить \"Смертельный союз\" к своим слугам!" -- Барон Ривендер пытается применить "Смертельный союз" к своим слугам!
end

-- Blackrock Spire (Vanilla through Mists only)

L = BigWigs:NewBossLocale("Pyroguard Emberseer", "ruRU")
if L then
	L.pyroguard_emberseer = "Пиростраж Углевзор"
end
