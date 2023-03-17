local L = BigWigs:NewBossLocale("Sadana Bloodfury", "deDE")
if not L then return end
if L then
	L.custom_on_markadd = "Add der Dunklen Kommunion markieren"
	L.custom_on_markadd_desc = "Markiert das durch die Dunkle Kommunion beschworene Add mit {rt8}, benötigt Assistent oder Leiter."
end

L = BigWigs:NewBossLocale("Bonemaw", "deDE")
if L then
	L.summon_worms = "Aaswürmer beschwören"
	L.summon_worms_desc = "Knochenschlund beschwört zwei Aaswürmer."
	L.summon_worms_trigger = "durchdringende Kreischen von Knochenschlund lockt die Aaswürmer in der Nähe an!"

	L.submerge = "Untertauchen"
	L.submerge_desc = "Knochenschlund taucht unter und positioniert sich neu."
	L.submerge_trigger = "zischt und zieht sich in die finsteren Tiefen zurück!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "deDE")
if L then
	L.shadowmoon_bonemender = "Knochenrenkerin des Schattenmondklans"
	L.reanimated_ritual_bones = "Reanimierte Ritualknochen"
	L.void_spawn = "Ausgeburt der Leere"
	L.shadowmoon_loyalist = "Getreue des Schattenmondklans"
	L.defiled_spirit = "Entweihter Geist"
	L.shadowmoon_dominator = "Beherrscher des Schattenmondklans"
	L.shadowmoon_exhumer = "Erweckerin des Schattenmondklans"
	L.exhumed_spirit = "Exhumierter Geist"
	L.monstrous_corpse_spider = "Monströse Leichenspinne"
	L.carrion_worm = "Aaswurm"
end
