local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhTW")
if not L then return end
if L then
	L.despawn_message = "虚空怨灵召回，帕萨雷恩进入狂暴状态"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhTW")
if L then
	L.bossName = "看守者鐵手"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhTW")
if L then
	L.bossName = "看守者蓋洛奇歐"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "zhTW")
if L then
	L.fixate_desc = "使施法者鎖定一個隨機目標。"
end
