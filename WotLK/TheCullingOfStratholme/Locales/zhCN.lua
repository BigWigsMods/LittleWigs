local L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	L.gossip_available = "可对话"
	--L.gossip_timer_trigger = "Glad you could make it, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "zhCN")
if L then
	--L.warmup_trigger = "We're going to finish this right now, Mal'Ganis."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "zhCN")
if L then
	--L.warmup_trigger = "Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul."
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "zhCN")
if L then
	L.name = "永恒腐蚀者"
end
