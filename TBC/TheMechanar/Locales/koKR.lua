local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "koKR")
if not L then return end
if L then
	L.despawn_message = "잠시 후 황천의 망령 사라짐"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "koKR")
if L then
	L.bossName = "문지기 무쇠주먹"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "koKR")
if L then
	L.bossName = "문지기 회전톱날"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "koKR")
if L then
	L.fixate_desc = "무작위 대상에게 시선을 고정합니다."
end
