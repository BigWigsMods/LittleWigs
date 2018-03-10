local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhCN")
if not L then return end
if L then
	L.despawn_message = "虛空怨靈將被召回！"
	L.despawn_trigger = "我比較喜歡自己動手做……"
	--L.despawn_trigger2 = "I prefer to be hands"
	L.despawn_done = "虛空怨靈已被召回，帕薩里歐進入狂怒狀態！"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "zhCN")
if L then
	--L.enrage_trigger = "You should split while you can."
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhCN")
if L then
	L.name = "看守者埃隆汉"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhCN")
if L then
	L.name = "看守者盖罗基尔"
end
