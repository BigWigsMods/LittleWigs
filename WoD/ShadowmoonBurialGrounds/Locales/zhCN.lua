local L = BigWigs:NewBossLocale("Sadana Bloodfury", "zhCN")
if not L then return end
if L then
	L.custom_on_markadd = "标记黑暗契约增援"
	L.custom_on_markadd_desc = "使用骷髅标记黑暗契约出现的增援，需要权限。"
end

L = BigWigs:NewBossLocale("Bonemaw", "zhCN")
if L then
	--L.summon_worms = "Summon Carrion Worms"
	--L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	--L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "下潜"
	--L.submerge_desc = "Bonemaw submerges and repositions."
	--L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "zhCN")
if L then
	L.shadowmoon_bonemender = "影月塑骨者"
	L.void_spawn = "虚空爪牙"
	L.shadowmoon_loyalist = "影月死忠者"
	L.shadowmoon_dominator = "影月统御者"
	L.shadowmoon_exhumer = "影月盗墓者"
	L.exhumed_spirit = "复苏的灵魂"
	L.monstrous_corpse_spider = "畸形僵尸蛛"
	L.carrion_worm = "食腐蛆虫"
end
