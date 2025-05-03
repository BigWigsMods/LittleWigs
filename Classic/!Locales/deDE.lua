-- Dire Maul

local L = BigWigs:NewBossLocale("Lethtendris", "deDE")
if not L then return end
if L then
	L.pimgib = "Pimgib"
end

-- Stratholme

L = BigWigs:NewBossLocale("Lord Aurius Rivendare", "deDE")
if L then
	L.death_pact_trigger = "versucht, 'Todespakt' auf seine Diener zu wirken!"
end

-- Blackrock Spire (Vanilla through Mists only)

L = BigWigs:NewBossLocale("Pyroguard Emberseer", "deDE")
if L then
	L.pyroguard_emberseer = "Feuerwache Glutseher"
end
