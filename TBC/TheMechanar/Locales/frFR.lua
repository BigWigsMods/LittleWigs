local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "frFR")
if not L then return end
if L then
	L.despawn_message = "Disparition des âmes en peine du Néant imminente"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "frFR")
if L then
	L.enrage_trigger = "Dégagez tant que vous le pouvez." -- à vérifier
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "frFR")
if L then
	L.name = "Gardien de porte Main-en-Fer"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "frFR")
if L then
	L.name = "Gardien de porte Gyro-Meurtre"
end
