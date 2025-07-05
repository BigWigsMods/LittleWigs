-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "zhTW")
if not L then return end
if L then
	L.affliction = "痛苦"
	L.demonology = "惡魔學識"
	L.destruction = "毀滅"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "zhTW")
if L then
	L.abyssal = "魔能冥淵火"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "zhTW")
if L then
	--L.bloodmaul_enforcer = "Bloodmaul Enforcer"
	--L.bloodmaul_overseer = "Bloodmaul Overseer"
	--L.bloodmaul_warder = "Bloodmaul Warder"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "zhTW")
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "給他們好看！"
	L.add_trigger2 = "火力全開！"

	L.waves[1] = "1x格羅姆卡砲手，1x格羅姆卡槍手"
	L.waves[2] = "1x格羅姆卡槍手，1x格羅姆卡擲彈手"
	L.waves[3] = "鋼鐵步兵"
	L.waves[4] = "2x格羅姆卡砲手"
	L.waves[5] = "鋼鐵步兵"
	L.waves[6] = "2x格羅姆卡槍手"
	L.waves[7] = "鋼鐵步兵"
	L.waves[8] = "1x格羅姆卡砲手，1x格羅姆卡擲彈手"
	L.waves[9] = "3x格羅姆卡砲手，1x格羅姆卡槍手"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "zhTW")
if L then
	--L.grimrail_technician = "Grimrail Technician"
	--L.grimrail_overseer = "Grimrail Overseer"
	L.gromkar_gunner = "格羅姆卡槍手"
	--L.gromkar_cinderseer = "Grom'kar Cinderseer"
	L.gromkar_boomer = "格羅姆卡砲手"
	--L.gromkar_hulk = "Grom'kar Hulk"
	--L.gromkar_far_seer = "Grom'kar Far Seer"
	--L.gromkar_captain = "Grom'kar Captain"
	--L.grimrail_scout = "Grimrail Scout"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "zhTW")
if L then
	--L.sphere_fail_message = "Shield was broken - They're all healing :("
end

L = BigWigs:NewBossLocale("Oshir", "zhTW")
if L then
	--L.freed = "Freed after %.1f sec!"
	--L.wolves = "Wolves"
	L.rylak = "萊拉克"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "zhTW")
if L then
	--L.gromkar_battlemaster = "Grom'kar Battlemaster"
	--L.gromkar_flameslinger = "Grom'kar Flameslinger"
	--L.gromkar_technician = "Grom'kar Technician"
	--L.siegemaster_olugar = "Siegemaster Olugar"
	--L.pitwarden_gwarnok = "Pitwarden Gwarnok"
	--L.ogron_laborer = "Ogron Laborer"
	--L.gromkar_chainmaster = "Grom'kar Chainmaster"
	--L.thunderlord_wrangler = "Thunderlord Wrangler"
	--L.rampaging_clefthoof = "Rampaging Clefthoof"
	--L.ironwing_flamespitter = "Ironwing Flamespitter"
end

-- Shadowmoon Burial Grounds

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

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "zhTW")
if L then
	L.solar_zealot = "太陽狂熱者"
	L.construct = "擎天護盾傀儡"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "zhTW")
if L then
	L.energyStatus = "元水之珠到達枯木: %d%% 能量"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "zhTW")
if L then
	L.dreadpetal = "恐瓣花"
	L.everbloom_naturalist = "永茂林自然療者"
	L.everbloom_cultivator = "永茂林護林者"
	--L.rockspine_stinger = "Rockspine Stinger"
	L.everbloom_mender = "永茂林治癒者"
	L.gnarlroot = "瘤根"
	L.melded_berserker = "混形狂戰士"
	--L.twisted_abomination = "Twisted Abomination"
	L.infested_icecaller = "被感染的喚冰師"
	L.putrid_pyromancer = "腐爛的火占師"
	L.addled_arcanomancer = "混亂的秘卜師"

	L.gate_open_desc = "顯示一個計時條指示黑暗法師克薩隆將開啟往亞爾努的傳送門。"
	L.yalnu_warmup_trigger = "我們一定要阻止這隻怪物，不能讓他逃脫！"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "zhTW")
if L then
	--L.counduitLeft = "%d |4Conduit:Conduits; left"
end
