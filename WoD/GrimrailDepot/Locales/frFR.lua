local L = BigWigs:NewBossLocale("Nitrogg Thundertower", "frFR")
if not L then return end
if L then
	--L.dropped = "%s dropped!"
	L.add_trigger1 = "Montrez-leur qui vous êtes, les gars !"
	L.add_trigger2 = "Donnez-leur tout ce que vous avez."

	L.waves[1] = "1x Boumeur grom’kar, 1x Mitrailleur grom’kar"
	L.waves[2] = "1x Mitrailleur grom’kar, 1x Grenadier grom’kar"
	L.waves[3] = "Soldat d’infanterie de Fer"
	L.waves[4] = "2x Boumeur grom’kar"
	L.waves[5] = "Soldat d’infanterie de Fer"
	L.waves[6] = "2x Mitrailleur grom’kar"
	L.waves[7] = "Soldat d’infanterie de Fer"
	L.waves[8] = "1x Boumeur grom’kar, 1x Grenadier grom’kar"
	L.waves[9] = "3x Boumeur grom’kar, 1x Mitrailleur grom’kar"
end

L = BigWigs:NewBossLocale("Grimrail Depot Trash", "frFR")
if L then
	L.grimrail_technician = "Technicien de Tristerail"
	L.grimrail_overseer = "Surveillant de Tristerail"
	L.gromkar_gunner = "Mitrailleur grom’kar"
	L.gromkar_cinderseer = "Voyant-de-braise grom’kar"
	L.gromkar_boomer = "Boumeur grom’kar"
	L.gromkar_hulk = "Butor grom’kar"
	L.gromkar_far_seer = "Long-voyant grom’kar"
	L.gromkar_captain = "Capitaine grom’kar"
	L.grimrail_scout = "Eclaireuse de Tristerail"
end
