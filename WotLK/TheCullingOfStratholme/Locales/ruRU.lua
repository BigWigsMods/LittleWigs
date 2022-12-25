local L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "ruRU")
if not L then return end
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly select Chromie's and Arthas's gossip options."

	--L.gossip_available = "Gossip available"
	L.gossip_timer_trigger = "Я рад, что ты пришел, Утер!"
end

L = BigWigs:NewBossLocale("Mal'Ganis", "ruRU")
if L then
	L.warmup_trigger = "Мы покончим с этим сейчас же, Мал'Ганис. Один на один."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "ruRU")
if L then
	-- Принц Артас Менетил, в этот самый день могущественное зло поглотило твою душу. Смерть, которую ты должен был принести другим, сегодня придет за тобой.
	L.warmup_trigger = "в этот самый день"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "ruRU")
if L then
	L.name = "Осквернитель из рода Бесконечности"
end
