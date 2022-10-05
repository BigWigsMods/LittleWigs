local L = BigWigs:NewBossLocale("Xevozz", "zhCN")
if not L then return end
if L then
	--L.sphere_name = "Ethereal Sphere"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "zhCN")
if L then
	--L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "zhCN")
if L then
	L.portals = "传送门"
	L.portals_desc = "传送门相关信息。"
	L.boss_message = "首领"
	L.portal_bar = "传送门"
end
