local L = BigWigs:NewBossLocale("Underrot Trash", "zhCN")
if not L then return end
if L then
	-- L.custom_on_fixate_plates = "Thirst For Blood icon on Enemy Nameplate"
	-- L.custom_on_fixate_plates_desc = "Show an icon on the target nameplate that is fixating on you.\nRequires the use of Enemy Nameplates. This feature is currently only supported by KuiNameplates."

	L.spirit = "亵渎之灵"
	L.priest = "虔诚鲜血祭司"
	L.maggot = "恶臭蛆虫"
	L.matron = "鲜血主母选民"
	L.lasher = "染病鞭笞者"
	L.bloodswarmer = "狂野的群居血虱"
	L.rot = "生命腐质"
	L.deathspeaker = "堕落的亡语者"
	L.defiler = "血誓污染者"
	L.corruptor = "无面腐蚀者"
end

L = BigWigs:NewBossLocale("Infested Crawg", "zhCN")
if L then
	L.random_cast = "冲锋或消化不良"
	L.random_cast_desc = "每次发脾气之后施放的第一个技能是随机的。"
end
