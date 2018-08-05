local L = BigWigs:NewBossLocale("Ancient Protectors", "ptBR")
if not L then return end
if L then
	L[83892] = "|cFF00CCFFGola|r"
	L[83893] = "|cFF00CC00Telu|r"

	L.custom_on_automark = "Marca automaticamente os chefes"
	L.custom_on_automark_desc = "Automaticamente marca Gola com {rt8} e Telu com {rt7}, requer promovido ou líder."
end

L = BigWigs:NewBossLocale("Witherbark", "ptBR")
if L then
	L.energyStatus = "Um glóbulo alcançou Cascasseca: %d%% energia"
end
