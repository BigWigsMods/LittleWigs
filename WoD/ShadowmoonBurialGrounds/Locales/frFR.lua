local L = BigWigs:NewBossLocale("Sadana Bloodfury", "frFR")
if not L then return end
if L then
	--L.custom_on_markadd = "Mark the Dark Communion Add"
	--L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
end

L = BigWigs:NewBossLocale("Bonemaw", "frFR")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Submerger"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "frFR")
if L then
	L.shadowmoon_bonemender = "Répare-os ombrelune"
	L.reanimated_ritual_bones = "Ossements rituels ranimés"
	L.void_spawn = "Rejeton du Vide"
	L.shadowmoon_loyalist = "Loyaliste ombrelune"
	L.defiled_spirit = "Esprit profané"
	L.shadowmoon_dominator = "Dominateur ombrelune"
	L.shadowmoon_exhumer = "Exhumeuse d’âmes ombrelune"
	L.exhumed_spirit = "Esprit exhumé"
	L.monstrous_corpse_spider = "Araignée nécrophage monstrueuse"
	L.carrion_worm = "Ver putride"
end
