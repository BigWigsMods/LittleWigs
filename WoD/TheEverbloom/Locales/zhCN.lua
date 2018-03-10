local L = BigWigs:NewBossLocale("Ancient Protectors", "zhCN")
if not L then return end
if L then
	L[83892] = "|cFF00CCFF高拉|r"
	L[83893] = "|cFF00CC00特鲁|r"

	L.custom_on_automark = "自动标记首领"
	L.custom_on_automark_desc = "自动标记高拉为 {rt8}，特鲁为 {rt7}，需要权限。"
end

L = BigWigs:NewBossLocale("Witherbark", "zhCN")
if L then
	L.energyStatus = "小水滴到达枯木：%d%% 能量"
end
