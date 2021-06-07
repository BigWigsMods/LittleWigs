local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "esES") or BigWigs:NewBossLocale("Pathaleon the Calculator", "esMX")
if not L then return end
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esES") or BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esMX")
if L then
	L.bossName = "Vigía de las puertas Manoyerro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "esES") or BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "esMX")
if L then
	L.bossName = "Vigía de las puertas Giromata"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "esES") or BigWigs:NewBossLocale("Nethermancer Sepethrea", "esMX")
if L then
	L.fixate_desc = "Provoca que el taumaturgo se fije en un objetivo aleatorio."
end
