local L = BigWigs:NewBossLocale("Sadana Bloodfury", "itIT")
if not L then return end
if L then
	--L.custom_on_markadd = "Mark the Dark Communion Add"
	--L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
end

L = BigWigs:NewBossLocale("Bonemaw", "itIT")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Immersione"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "itIT")
if L then
	L.shadowmoon_bonemender = "Curaossa Torvaluna"
	L.reanimated_ritual_bones = "Scheletro Rituale Rianimato"
	L.void_spawn = "Creatura del Vuoto"
	L.shadowmoon_loyalist = "Lealista Torvaluna"
	L.defiled_spirit = "Spirito Profanato"
	L.shadowmoon_dominator = "Dominatore di Torvaluna"
	L.shadowmoon_exhumer = "Esumatore Torvaluna"
	L.exhumed_spirit = "Spirito Riesumato"
	L.monstrous_corpse_spider = "Ragno Cadaverico Mostruoso"
	L.carrion_worm = "Verme Carogna"
end
