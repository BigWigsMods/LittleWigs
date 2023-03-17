local L = BigWigs:NewBossLocale("Sadana Bloodfury", "zhTW")
if not L then return end
if L then
	L.custom_on_markadd = "標記被玷汙的靈魂"
	L.custom_on_markadd_desc = "用 {rt8} 標記黑暗共融召喚的靈魂，需要權限。"
end

L = BigWigs:NewBossLocale("Bonemaw", "zhTW")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	--L.submerge = "Submerge"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "zhTW")
if L then
	L.shadowmoon_bonemender = "影月修骨者"
	--L.reanimated_ritual_bones = "Reanimated Ritual Bones"
	L.void_spawn = "虛無生靈"
	L.shadowmoon_loyalist = "影月忠誠者"
	--L.defiled_spirit = "Defiled Spirit"
	--L.shadowmoon_dominator = "Shadowmoon Dominator"
	L.shadowmoon_exhumer = "影月挖掘者"
	L.exhumed_spirit = "掘出的靈魂"
	L.monstrous_corpse_spider = "巨型屍蛛"
	L.carrion_worm = "食腐骨蟲"
end
