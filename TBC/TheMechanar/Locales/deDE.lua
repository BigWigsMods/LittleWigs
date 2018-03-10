local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "deDE")
if not L then return end
if L then
	L.despawn_message = "Nethergespenster verschwinden bald"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "deDE")
if L then
	L.name = "Torwächter Eisenhand"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "deDE")
if L then
	L.name = "Torwächter Gyrotod"
end
