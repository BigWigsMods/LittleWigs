local L = BigWigs:NewBossLocale("Mephistroth", "deDE")
if not L then return end
if L then
	L.custom_on_time_lost = "Verlorene Zeit während Schattenverblassen"
	L.custom_on_time_lost_desc = "Zeigt die verlorene Zeit während Schattenverblassen in der Leiste in |cffff0000red|r."
end

L = BigWigs:NewBossLocale("Domatrax", "deDE")
if L then
	L.custom_on_autotalk = "Automatisch ansprechen"
	L.custom_on_autotalk_desc = "Wählt direkt Aegis von Aggramars Dialogoption um den Kampf gegen Domatrax zu starten."

	L.missing_aegis = "Du stehst nicht im Aegis" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "Aegis: Reduzierte Heilung"
	L.aegis_damage = "Aegis: Reduzierter verursachter Schaden"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "deDE")
if L then
	L.dulzak = "Dul'zak"
	L.wrathguard = "Einfallender Zornwächter"
	L.felguard = "Zerstörer der Teufelswache"
	L.soulmender = "Höllenglutseelenheiler"
	L.temptress = "Höllenglutverführerin"
	L.botanist = "Teufelsgeborene Botanikerin"
	L.orbcaster = "Sphärenwirker der Teufelsschreiter"
	L.waglur = "Wa'glur"
	L.scavenger = "Wyrmzungenplünderer"
	L.gazerax = "Gazerax"
	L.vilebark = "Übelrindenläufer"

	L.throw_tome = "Folianten werfen" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end
