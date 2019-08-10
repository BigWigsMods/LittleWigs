local L = BigWigs:NewBossLocale("Underrot Trash", "zhTW")
if not L then return end
if L then
	-- L.custom_on_fixate_plates = "Thirst For Blood icon on Enemy Nameplate"
	-- L.custom_on_fixate_plates_desc = "Show an icon on the target nameplate that is fixating on you.\nRequires the use of Enemy Nameplates. This feature is currently only supported by KuiNameplates."

	L.spirit = "被玷污的靈魂"
	L.priest = "虔誠的鮮血祭司"
	L.maggot = "惡臭蛆蟲"
	L.matron = "受選之血族母"
	L.lasher = "染病的鞭笞者"
	L.bloodswarmer = "野生鮮血蟲"
	L.rot = "活體腐質"
	L.deathspeaker = "死亡的亡頌者"
	L.defiler = "血誓污染者"
	L.corruptor = "無面墮落者"
end

L = BigWigs:NewBossLocale("Infested Crawg", "zhTW")
if L then
	L.random_cast = "衝鋒或噴吐"
	L.random_cast_desc = "每次暴怒後施放的第一個技能是隨機的。"
end
