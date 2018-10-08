local L = BigWigs:NewBossLocale("Ancient Protectors", "deDE")
if not L then return end
if L then
	L[83892] = "|cFF00CCFFGola|r"
	L[83893] = "|cFF00CC00Telu|r"

	L.custom_on_automark = "Bosse automatisch markieren"
	L.custom_on_automark_desc = "Markiert Gola automatisch mit {rt8} und Telu mit {rt7}, benötigt Assistent oder Leiter."
end

L = BigWigs:NewBossLocale("Witherbark", "deDE")
if L then
	L.energyStatus = "Eine Sphäre hat Bleichborke erreicht: %d%% Energie"
end
