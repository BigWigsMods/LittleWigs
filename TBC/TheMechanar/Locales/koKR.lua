local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "koKR")
if not L then return end
if L then
	L.despawn_message = "잠시 후 황천의 망령 사라짐!"
	L.despawn_trigger = "진짜 싸움을 시작해 볼까..."
	--L.despawn_trigger2 = "I prefer to be hands"
	L.despawn_done = "황천의 망령 사라짐!"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "koKR")
if L then
	--L.enrage_trigger = "You should split while you can."
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "koKR")
if L then
	L.name = "문지기 무쇠주먹"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "koKR")
if L then
	L.name = "문지기 회전톱날"
end
