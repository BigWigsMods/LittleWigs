local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "ruRU")
if not L then return end
if L then
	L.despawn_message = "Скоро Призраки Хаоса исчезнут!"
	--L.despawn_trigger = "I prefer the direct"
	--L.despawn_trigger2 = "I prefer to be hands"
	L.despawn_done = "Призраки Хаоса исчезли!"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "ruRU")
if L then
	--L.enrage_trigger = "You should split while you can."
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "ruRU")
if L then
	--L.hammer_trigger = "raises his hammer menacingly"
end
