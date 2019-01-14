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

L = BigWigs:NewBossLocale("Shrine of the Storm Trash", "deDE")
if L then
	L.templar = "Schreintempler"
	L.spiritualist = "Spiritualistin der Gezeitenweisen"
	L.galecaller_apprentice = "Sturmbeschwörerlehrling"
	L.windspeaker = "Windsprecherin Heldis"
	L.ironhull_apprentice = "Lehrling von Eisenkiel"
	L.runecarver = "Runenmetz Sorn"
	L.guardian_elemental = "Wächterelementar"
	L.ritualist = "Tiefseeritualist"
	L.cultist = "Abgrundkultist"
	L.depthbringer = "Ertrunkener Tiefenbringer"
	L.living_current = "Lebendige Strömung"
	L.enforcer = "Vollstrecker der Gezeitenweisen"
end
