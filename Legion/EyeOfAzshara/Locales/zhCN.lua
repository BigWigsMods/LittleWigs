local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "zhCN")
if not L then return end
if L then
	L.wrangler = "积怨牧鱼者"
	L.stormweaver = "积怨织雷者"
	L.crusher = "积怨碾压者"
	L.oracle = "积怨神谕者"
	L.siltwalker = "玛拉纳沙地行者"
	L.tides = "焦躁的海潮元素"
	L.arcanist = "积怨奥术师"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "zhCN")
if L then
	L.custom_on_show_helper_messages = "静电新星和凝聚闪电帮助信息"
	L.custom_on_show_helper_messages_desc = "启用此选项当首领开始施放|cff71d5ff静电新星|r或|cff71d5ff凝聚闪电|r时添加告知自身水中或沙丘安全的信息。"

	L.water_safe = "%s（水中安全）"
	L.land_safe = "%s（沙丘安全）"
end
