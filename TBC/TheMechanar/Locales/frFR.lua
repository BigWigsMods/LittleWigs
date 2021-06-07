local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "frFR")
if not L then return end
if L then
	L.despawn_message = "Disparition des âmes en peine du Néant imminente"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "frFR")
if L then
	L.bossName = "Gardien de porte Main-en-Fer"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "frFR")
if L then
	L.bossName = "Gardien de porte Gyro-Meurtre"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "frFR")
if L then
	L.fixate_desc = "Le lanceur de sorts se concentre sur une cible aléatoire."
end
