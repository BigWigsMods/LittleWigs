local L = BigWigs:NewBossLocale("Aqu'sirr", "deDE")
if not L then return end
if L then
	L.warmup_trigger = "Wagt es nicht, diesen heiligen Ort mit Eurer Anwesenheit zu schänden!"
end

L = BigWigs:NewBossLocale("Lord Stormsong", "deDE")
if L then
	L.warmup_trigger_horde = "Eindringlinge?! Ich versenke Eure Leichen in den schwarzen Tiefen, wo sie auf ewig gemartert werden!"
	L.warmup_trigger_alliance = "Meister! Stoppt diesen Wahnsinn! Die Flotte von Kul Tiras darf nicht der Dunkelheit anheimfallen!"
end
