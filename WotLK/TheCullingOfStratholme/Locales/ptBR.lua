local L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "ptBR")
if not L then return end
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	--L.gossip_available = "Gossip available"
	--L.gossip_timer_trigger = "Glad you could make it, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "ptBR")
if L then
	--L.warmup_trigger = "We're going to finish this right now, Mal'Ganis. Just you... and me."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "ptBR")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	--L.warmup_trigger = "on this day"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "ptBR")
if L then
	L.name = "Corruptor Infinito"
end
