local L = BigWigs:NewBossLocale("Xevozz", "esES") or BigWigs:NewBossLocale("Xevozz", "esMX")
if not L then return end
if L then
	--L.sphere_name = "Ethereal Sphere"
end

L = BigWigs:NewBossLocale("Zuramat the Obliterator", "esES") or BigWigs:NewBossLocale("Zuramat the Obliterator", "esMX")
if L then
	--L.short_name = "Zuramat"
end

L = BigWigs:NewBossLocale("The Violet Hold Trash", "esES") or BigWigs:NewBossLocale("The Violet Hold Trash", "esMX")
if L then
	--L.portals = "Portals"
	--L.portals_desc = "Information about portals."
	L.boss_message = "Jefe"
	L.portal_bar = "Portal"
end
