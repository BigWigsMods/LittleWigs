-- Dire Maul

local L = BigWigs:NewBossLocale("Lethtendris", "esES")
if not L then return end
if L then
	L.pimgib = "Pimgib"
end

-- Stratholme

L = BigWigs:NewBossLocale("Lord Aurius Rivendare", "esES")
if L then
	L.death_pact_trigger = "intenta lanzar un Pacto de muerte a sus sirvientes!" -- ¡Lord Aurius Osahendido intenta lanzar un Pacto de muerte a sus sirvientes!
end

-- Blackrock Spire (Vanilla through Mists only)

L = BigWigs:NewBossLocale("Pyroguard Emberseer", "esES")
if L then
	L.pyroguard_emberseer = "Piroguardia Brasadivino"
end
