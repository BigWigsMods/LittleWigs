local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhCN")
if not L then return end
if L then
	L.despawn_message = "虚空怨灵即将召回"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhCN")
if L then
	L.bossName = "看守者埃隆汉"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhCN")
if L then
	L.bossName = "看守者盖罗基尔"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "zhCN")
if L then
	L.fixate_desc = "使施法者锁定一个随机目标。"
end
