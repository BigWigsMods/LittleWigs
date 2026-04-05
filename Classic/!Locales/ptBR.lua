-- Dire Maul

local L = BigWigs:NewBossLocale("Lethtendris", "ptBR")
if not L then return end
if L then
	L.pimgib = "Diabretão"
end

-- Stratholme

L = BigWigs:NewBossLocale("Lord Aurius Rivendare", "ptBR")
if L then
	L.death_pact_trigger = "tenta lançar o Pacto da Morte nos próprios servos!"
end

-- Blackrock Spire (Vanilla through Mists only)

L = BigWigs:NewBossLocale("Pyroguard Emberseer", "ptBR")
if L then
	L.pyroguard_emberseer = "Piroguarda Mirabrasa"
end
