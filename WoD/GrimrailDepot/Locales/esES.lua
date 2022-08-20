local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "esES") or BigWigs:NewBossLocale("Nitrogg Thundertower", "esMX")
if not L then return end
if L then
	L.comma = ", "
	--L.dropped = "%s dropped!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "esES") or BigWigs:NewBossLocale("Skylord Tovra", "esMX")
if L then
	L.rakun = "Rakun"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "esES") or BigWigs:NewBossLocale("Grimrail Depot Trash", "esMX")
if L then
	L.grimrail_technician = "Técnico Malavía"
	L.grimrail_overseer = "Sobrestante Malavía"
	L.gromkar_gunner = "Artillera Grom'kar"
	L.gromkar_cinderseer = "Vidente de las cenizas Grom'kar"
	L.gromkar_boomer = "Dinamitero Grom'kar"
	L.gromkar_far_seer = "Clarividente Grom'kar"
	L.gromkar_captain = "Capitana Grom'kar"
	L.grimrail_scout = "Exploradora Malavía"
end
