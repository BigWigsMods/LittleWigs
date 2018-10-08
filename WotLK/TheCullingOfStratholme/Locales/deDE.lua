local L = BigWigs:NewBossLocale("The Culling of Stratholme Trash", "deDE")
if not L then return end
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt Chromies und Arthas' Dialogoptionen."

	L.gossip_available = "Dialog verfügbar"
	L.gossip_timer_trigger = "Wie schön, dass Ihr es geschafft habt, Uther."
end

L = BigWigs:NewBossLocale("Mal'Ganis", "deDE")
if L then
	L.warmup_trigger = "Wir beenden das hier und jetzt, Mal'Ganis. Nur wir beide, sonst niemand."
end

L = BigWigs:NewBossLocale("Chrono-Lord Epoch", "deDE")
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	L.warmup_trigger = "eine große Finsternis"
end

L = BigWigs:NewBossLocale("Infinite Corruptor", "deDE")
if L then
	L.name = "Ewiger Verderber"
end
