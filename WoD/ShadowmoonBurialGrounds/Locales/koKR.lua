local L = BigWigs:NewBossLocale("Sadana Bloodfury", "koKR")
if not L then return end
if L then
	--L.custom_on_markadd = "Mark the Dark Communion Add"
	--L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
end

L = BigWigs:NewBossLocale("Bonemaw", "koKR")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "땅속 숨기"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "koKR")
if L then
	L.shadowmoon_bonemender = "어둠달 뼛조각치유사"
	L.reanimated_ritual_bones = "되살린 의식 해골"
	L.void_spawn = "공허의 피조물"
	L.shadowmoon_loyalist = "어둠달 충성주의자"
	L.defiled_spirit = "더럽혀진 영혼"
	L.shadowmoon_dominator = "어둠달 통솔자"
	L.shadowmoon_exhumer = "어둠달 도굴꾼"
	L.exhumed_spirit = "도굴된 영혼"
	L.monstrous_corpse_spider = "기괴한 시체 거미"
	L.carrion_worm = "청소부 벌레"
end
