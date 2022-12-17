local L = BigWigs:NewBossLocale("Sadana Bloodfury", "esES") or BigWigs:NewBossLocale("Sadana Bloodfury", "esMX")
if not L then return end
if L then
	--L.custom_on_markadd = "Mark the Dark Communion Add"
	--L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "esES") or BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "esMX")
if L then
	L.shadowmoon_bonemender = "Ensalmadora de huesos Sombraluna"
	L.void_spawn = "Engendro del Vacío"
	L.shadowmoon_loyalist = "Leal Sombraluna"
	L.shadowmoon_exhumer = "Exhumadora Sombraluna"
	L.exhumed_spirit = "Espíritu exhumado"
	L.monstrous_corpse_spider = "Araña cadáver monstruosa"
	L.carrion_worm = "Gusano carroñero"
end
