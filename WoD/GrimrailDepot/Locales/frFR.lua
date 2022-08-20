local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "frFR")
if not L then return end
if L then
	L.comma = ", "
	--L.dropped = "%s dropped!"
	--L.add_trigger1 = "Let 'em have it, boys!"
	--L.add_trigger2 = "Give 'em all ya got."
end

L = BigWigs:NewBossLocale("Skylord Tovra", "frFR")
if L then
	L.rakun = "Rakun"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "frFR")
if L then
	L.grimrail_technician = "Technicien de Tristerail"
	L.grimrail_overseer = "Surveillant de Tristerail"
	L.gromkar_gunner = "Mitrailleur grom’kar"
	L.gromkar_cinderseer = "Voyant-de-braise grom’kar"
	L.gromkar_boomer = "Boumeur grom’kar"
	L.gromkar_far_seer = "Long-voyant grom’kar"
	L.gromkar_captain = "Capitaine grom’kar"
	L.grimrail_scout = "Eclaireuse de Tristerail"
end
