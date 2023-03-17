local L = BigWigs:NewBossLocale("Sadana Bloodfury", "esES") or BigWigs:NewBossLocale("Sadana Bloodfury", "esMX")
if not L then return end
if L then
	--L.custom_on_markadd = "Mark the Dark Communion Add"
	--L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
end

L = BigWigs:NewBossLocale("Bonemaw", "esES") or BigWigs:NewBossLocale("Bonemaw", "esMX")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Sumersión"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "esES") or BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "esMX")
if L then
	L.shadowmoon_bonemender = "Ensalmadora de huesos Sombraluna"
	L.reanimated_ritual_bones = "Huesos de ritual reanimados"
	L.void_spawn = "Engendro del Vacío"
	L.shadowmoon_loyalist = "Leal Sombraluna"
	L.defiled_spirit = "Espíritu profanado"
	L.shadowmoon_dominator = "Dominador Sombraluna"
	L.shadowmoon_exhumer = "Exhumadora Sombraluna"
	L.exhumed_spirit = "Espíritu exhumado"
	L.monstrous_corpse_spider = "Araña cadáver monstruosa"
	L.carrion_worm = "Gusano carroñero"
end
