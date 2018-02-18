local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "esES") or BigWigs:NewBossLocale("Pathaleon the Calculator", "esMX")
if not L then return end
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon!"
	--L.despawn_trigger = "I prefer the direct"
	--L.despawn_trigger2 = "I prefer to be hands"
	--L.despawn_done = "Nether Wraiths despawning!"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "esES") or BigWigs:NewBossLocale("Mechano-Lord Capacitus", "esMX")
if L then
	--L.enrage_trigger = "You should split while you can."
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esES") or BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esMX")
if L then
	L.hammer_trigger = "alza su martillo amenazadoramente"
end
