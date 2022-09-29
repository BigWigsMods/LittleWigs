local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "zhTW")
if not L then return end
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
