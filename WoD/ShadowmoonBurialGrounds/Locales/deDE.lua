local L = BigWigs:NewBossLocale("Sadana Bloodfury", "deDE")
if not L then return end
if L then
	L.custom_on_markadd = "Add der Dunklen Kommunion markieren"
	L.custom_on_markadd_desc = "Markiert das durch die Dunkle Kommunion beschworene Add mit {rt8}, benötigt Assistent oder Leiter."
end

L = BigWigs:NewBossLocale("Bonemaw", "deDE")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Untertauchen"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "deDE")
if L then
	L.shadowmoon_bonemender = "Knochenrenkerin des Schattenmondklans"
	L.void_spawn = "Ausgeburt der Leere"
	L.shadowmoon_loyalist = "Getreue des Schattenmondklans"
	L.shadowmoon_dominator = "Beherrscher des Schattenmondklans"
	L.shadowmoon_exhumer = "Erweckerin des Schattenmondklans"
	L.exhumed_spirit = "Exhumierter Geist"
	L.monstrous_corpse_spider = "Monströse Leichenspinne"
	L.carrion_worm = "Aaswurm"
end
