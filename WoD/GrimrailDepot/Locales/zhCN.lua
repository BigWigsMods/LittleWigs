local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "zhCN")
if not L then return end
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
