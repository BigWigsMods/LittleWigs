local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhTW")
if not L then return end
if L then
	L.despawn_message = "虚空怨灵召回，帕萨雷恩进入狂暴状态！"
	--L.despawn_trigger = "I prefer the direct"
	L.despawn_trigger2 = "我喜欢自己动手……"
	L.despawn_done = "虚空怨灵被召回！进入狂怒状态！"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "zhTW")
if L then
	--L.enrage_trigger = "You should split while you can."
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhTW")
if L then
	L.hammer_trigger = "威嚇地舉起他的錘子……"
end
