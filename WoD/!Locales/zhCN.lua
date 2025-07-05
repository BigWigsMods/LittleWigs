-- Auchindoun

local L = BigWigs:NewBossLocale("Teron'gor", "zhCN")
if not L then return end
if L then
	L.affliction = "痛苦"
	L.demonology = "恶魔学识"
	L.destruction = "毁灭"
end

L = BigWigs:NewBossLocale("Auchindoun Trash", "zhCN")
if L then
	L.abyssal = "邪脉深渊魔"
end

-- Bloodmaul Slag Mines

L = BigWigs:NewBossLocale("Bloodmaul Slag Mines Trash", "zhCN")
if L then
	L.bloodmaul_enforcer = "血槌执法者"
	L.bloodmaul_overseer = "血槌监工"
	L.bloodmaul_warder = "血槌典狱官"
end

-- Grimrail Depot

L = BigWigs:NewBossLocale("Nitrogg Thundertower", "zhCN")
if L then
	L.dropped = "%s已掉落！"
	L.add_trigger1 = "让他们尝尝厉害吧，小伙子们！"
	L.add_trigger2 = "火力全开。"

	L.waves[1] = "1x格罗姆卡爆破手，1x格罗姆卡枪手"
	L.waves[2] = "1x格罗姆卡枪手，1x格罗姆卡掷弹兵"
	L.waves[3] = "钢铁步兵"
	L.waves[4] = "2x格罗姆卡爆破手"
	L.waves[5] = "钢铁步兵"
	L.waves[6] = "2x格罗姆卡枪手"
	L.waves[7] = "钢铁步兵"
	L.waves[8] = "1x格罗姆卡爆破手，1x格罗姆卡掷弹兵"
	L.waves[9] = "3x格罗姆卡爆破手，1x格罗姆卡枪手"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "zhCN")
if L then
	L.grimrail_technician = "恐轨技师"
	L.grimrail_overseer = "恐轨监工"
	L.gromkar_gunner = "格罗姆卡枪手"
	L.gromkar_cinderseer = "格罗姆卡燃烬先知"
	L.gromkar_boomer = "格罗姆卡爆破手"
	L.gromkar_hulk = "格罗姆卡蛮兵"
	L.gromkar_far_seer = "格罗姆卡先知"
	L.gromkar_captain = "格罗姆卡上尉"
	L.grimrail_scout = "恐轨斥候"
end

-- Iron Docks

L = BigWigs:NewBossLocale("Grimrail Enforcers", "zhCN")
if L then
	L.sphere_fail_message = "血球被移除 - 他们恢复血量 :("
end

L = BigWigs:NewBossLocale("Oshir", "zhCN")
if L then
	L.freed = "%.1f秒后，进食时间！"
	L.wolves = "狼队"
	L.rylak = "双头飞龙"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "zhCN")
if L then
	L.gromkar_battlemaster = "格罗姆卡战斗大师"
	L.gromkar_flameslinger = "格罗姆卡火箭手"
	L.gromkar_technician = "格罗姆卡技师"
	L.siegemaster_olugar = "攻城大师奥鲁加"
	L.pitwarden_gwarnok = "训练场守卫加诺克"
	L.ogron_laborer = "独眼魔工人"
	L.gromkar_chainmaster = "格罗姆卡锁链大师"
	L.thunderlord_wrangler = "雷神驯兽师"
	L.rampaging_clefthoof = "狂怒的裂蹄牛"
	L.ironwing_flamespitter = "铁翼喷火者"
end

-- Shadowmoon Burial Grounds

L = BigWigs:NewBossLocale("Bonemaw", "zhCN")
if L then
	L.summon_worms = "召唤食腐蛆虫"
	L.summon_worms_desc = "骨喉召唤两个食腐蛆虫。"
	L.summon_worms_trigger = "骨喉刺耳的尖叫声引来了附近的食腐蛆虫！"

	L.submerge = "下潜"
	L.submerge_desc = "骨喉下潜和重现。"
	L.submerge_trigger = "骨喉嘶鸣着退回了暗影深渊！"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "zhCN")
if L then
	L.shadowmoon_bonemender = "影月塑骨者"
	L.reanimated_ritual_bones = "复苏的祭祀之骨"
	L.void_spawn = "虚空爪牙"
	L.shadowmoon_loyalist = "影月死忠者"
	L.defiled_spirit = "被亵渎的幽灵"
	L.shadowmoon_dominator = "影月统御者"
	L.shadowmoon_exhumer = "影月盗墓者"
	L.exhumed_spirit = "复苏的灵魂"
	L.monstrous_corpse_spider = "畸形僵尸蛛"
	L.carrion_worm = "食腐蛆虫"
end

-- Skyreach

L = BigWigs:NewBossLocale("High Sage Viryx", "zhCN")
if L then
	L.solar_zealot = "拜日狂信徒"
	L.construct = "通天峰防护构装体"
end

-- The Everbloom

L = BigWigs:NewBossLocale("Witherbark", "zhCN")
if L then
	L.energyStatus = "小水滴到达枯木：%d%% 能量"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "zhCN")
if L then
	L.dreadpetal = "恐瓣"
	L.everbloom_naturalist = "永茂博学者"
	L.everbloom_cultivator = "永茂栽培者"
	L.rockspine_stinger = "石脊钉刺者"
	L.everbloom_mender = "永茂栽培者"
	L.gnarlroot = "瘤根"
	L.melded_berserker = "融合狂战士"
	L.twisted_abomination = "扭曲的憎恶"
	L.infested_icecaller = "被感染的唤冰者"
	L.putrid_pyromancer = "腐烂的炎术士"
	L.addled_arcanomancer = "疯狂的奥法师"

	L.gate_open_desc = "显示下级法师克萨伦何时打开通往雅努大门的计时条。"
	L.yalnu_warmup_trigger = "传送门失守了！我们必须在这头野兽逃跑前阻止它！"
end

-- Upper Blackrock Spire

L = BigWigs:NewBossLocale("Orebender Gor'ashan", "zhCN")
if L then
	L.counduitLeft = "%d 导管剩余"
end
