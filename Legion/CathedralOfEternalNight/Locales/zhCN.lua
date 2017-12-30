local L = BigWigs:NewBossLocale("Mephistroth", "zhCN")
if not L then return end
if L then
	L.custom_on_time_lost = "暗影消退计时"
	L.custom_on_time_lost_desc = "显示暗影消退为|cffff0000红|r色计时条。"
end

L = BigWigs:NewBossLocale("Domatrax", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择阿格拉玛之盾对话开始与多玛塔克斯战斗。"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "zhCN")
if L then
	L.dulzak = "杜尔扎克"
	L.felguard = "恶魔卫士毁灭者"
	L.soulmender = "鬼火慰魂者"
	L.temptress = "鬼焰女妖"
	L.botanist = "邪脉植物学家"
	L.orbcaster = "邪足晶球法师"
	L.waglur = "瓦格鲁尔"
	L.gazerax = "加泽拉克斯"
	L.vilebark = "邪皮行者"
end
