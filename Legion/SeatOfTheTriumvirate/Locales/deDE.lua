local L = BigWigs:NewBossLocale("Viceroy Nezhar", "deDE")
if not L then return end
if L then
	L.tentacles = "Tentakel"
	L.guards = "Hüter"
	L.interrupted = "%s unterbrach %s (%.1fs übrig)!"
end

L = BigWigs:NewBossLocale("L'ura", "deDE")
if L then
	L.warmup_text = "L'ura aktiv"
	L.warmup_trigger = "Dieses Chaos... diese Qualen. Etwas Derartiges habe ich noch nie gespürt."
	L.warmup_trigger_2 = "Derlei Gedanken können jetzt warten. Dieses Wesen muss sterben."
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "deDE")
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt Alleria Windläufers Dialogoption."
	L.gossip_available = "Dialog verfügbar"
	L.alleria_gossip_trigger = "Folgt mir!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Windläufer"
	L.subjugator = "Unterwerfer der Schattenwache"
	L.voidbender = "Leerenformer der Schattenwache"
	L.conjurer = "Beschwörer der Schattenwache"
	L.weaver = "Großschattenwirker"
end
