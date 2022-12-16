local L = BigWigs:NewBossLocale("Sadana Bloodfury", "deDE")
if not L then return end
if L then
	L.custom_on_markadd = "Add der Dunklen Kommunion markieren"
	L.custom_on_markadd_desc = "Markiert das durch die Dunkle Kommunion beschworene Add mit {rt8}, benötigt Assistent oder Leiter."
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "deDE")
if L then
	L.shadowmoon_bonemender = "Knochenrenkerin des Schattenmondklans"
	L.void_spawn = "Ausgeburt der Leere"
	L.shadowmoon_loyalist = "Getreue des Schattenmondklans"
	L.shadowmoon_exhumer = "Erweckerin des Schattenmondklans"
	L.exhumed_spirit = "Exhumierter Geist"
	L.monstrous_corpse_spider = "Monströse Leichenspinne"
	L.carrion_worm = "Aaswurm"
end
