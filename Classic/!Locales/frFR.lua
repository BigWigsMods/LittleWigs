-- Dire Maul

local L = BigWigs:NewBossLocale("Lethtendris", "frFR")
if not L then return end
if L then
	L.pimgib = "Pimgib"
end

-- Stratholme

L = BigWigs:NewBossLocale("Lord Aurius Rivendare", "frFR")
if L then
	L.death_pact_trigger = "Essaie de lancer Pacte mortel sur ses serviteurs !"
end

-- Blackrock Spire (Vanilla through Mists only)

L = BigWigs:NewBossLocale("Pyroguard Emberseer", "frFR")
if L then
	L.pyroguard_emberseer = "Pyrogarde Prophète ardent"
end