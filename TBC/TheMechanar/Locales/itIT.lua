local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "itIT")
if not L then return end
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "itIT")
if L then
	L.bossName = "Guardiano del Portale Mandiferro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "itIT")
if L then
	L.bossName = "Guardiano del Portale Giro-Morte"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "itIT")
if L then
	L.fixate_desc = "Induce l'incantatore a prendere di mira un bersaglio casuale."
end
