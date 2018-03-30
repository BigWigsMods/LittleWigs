local L = BigWigs:NewBossLocale("Mephistroth", "deDE")
if not L then return end
if L then
	--L.custom_on_time_lost = "Time lost during Shadow Fade"
	--L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
end

L = BigWigs:NewBossLocale("Domatrax", "deDE")
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects the Aegis of Aggramar's gossip option to start the Domatrax encounter."

	--L.missing_aegis = "You're not standing in Aegis" -- Aegis is a short name for Aegis of Aggramar
	--L.aegis_healing = "Aegis: Reduced Healing Done"
	--L.aegis_damage = "Aegis: Reduced Damage Done"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "deDE")
if L then
	L.dulzak = "Dul'zak"
	--L.wrathguard = "Wrathguard Invader"
	L.felguard = "Zerstörer der Teufelswache"
	L.soulmender = "Höllenglutseelenheiler"
	L.temptress = "Höllenglutverführerin"
	L.botanist = "Teufelsgeborene Botanikerin"
	L.orbcaster = "Sphärenwirker der Teufelsschreiter"
	L.waglur = "Wa'glur"
	L.scavenger = "Wyrmzungenplünderer"
	L.gazerax = "Gazerax"
	L.vilebark = "Übelrindenläufer"

	--L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end
