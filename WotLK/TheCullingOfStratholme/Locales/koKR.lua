local L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "koKR")
if not L then return end
if L then
	L.custom_on_autotalk = "자동 대화"
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	L.gossip_available = "대화 가능"
	--L.gossip_timer_trigger = "Glad you could make it, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "koKR")
if L then
	--L.warmup_trigger = "We're going to finish this right now, Mal'Ganis."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "koKR")
if L then
	--L.warmup_trigger = "Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul."
end
